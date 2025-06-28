using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WEBBANGIAY
{
    public partial class Admin : Page
    {
        private string ConnectionString => ConfigurationManager.ConnectionStrings["ShoeStoreDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated || GetUserRole(User.Identity.Name) != "admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                BindProductsGridView();
                BindUsersGridView();
            }
        }

        private string GetUserRole(string username)
        {
            string loaiUser = string.Empty;
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "SELECT LoaiUser FROM dbo.Users WHERE Username=@Username";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    try
                    {
                        con.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            loaiUser = result.ToString();
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Lỗi khi lấy vai trò người dùng: " + ex.Message);
                    }
                }
            }
            return loaiUser;
        }

        private void BindProductsGridView()
        {
            string query = "SELECT SanPhamID, TenSanPham, MoTaNgan, MoTaChiTiet, GiaBanLe, HangSanXuatID, NgayNhap, TrangThai FROM SanPham";
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    try
                    {
                        con.Open();
                        da.Fill(dt);
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                    catch (SqlException sqlEx)
                    {
                        litProductMessage.Text = "<span style='color:red;'>Lỗi SQL khi tải sản phẩm: " + sqlEx.Message + "</span>";
                    }
                    catch (Exception ex)
                    {
                        litProductMessage.Text = "<span style='color:red;'>Lỗi chung khi tải sản phẩm: " + ex.Message + "</span>";
                    }
                }
            }
        }


        private void BindUsersGridView()
        {
            string query = "SELECT UserID, Username, LoaiUser, Password FROM dbo.Users";
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    try
                    {
                        con.Open();
                        da.Fill(dt);
                        gvUsers.DataSource = dt;
                        gvUsers.DataBind();
                    }
                    catch (SqlException sqlEx)
                    {
                        litUserMessage.Text = "<span style='color:red;'>Lỗi SQL khi tải người dùng: " + sqlEx.Message + "</span>";
                    }
                    catch (Exception ex)
                    {
                        litUserMessage.Text = "<span style='color:red;'>Lỗi chung khi tải người dùng: " + ex.Message + "</span>";
                    }
                }
            }
        }

        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProducts.PageIndex = e.NewPageIndex;
            BindProductsGridView();
        }


        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            BindUsersGridView();
        }

        protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int sanPhamID = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlTransaction transaction = null;
                try
                {
                    con.Open();
                    transaction = con.BeginTransaction();

                    // 1. Xóa các bản ghi liên quan trong bảng BienTheSanPham trước
                    string deleteBienTheQuery = "DELETE FROM BienTheSanPham WHERE SanPhamID = @SanPhamID";
                    using (SqlCommand cmdBienThe = new SqlCommand(deleteBienTheQuery, con, transaction))
                    {
                        cmdBienThe.Parameters.AddWithValue("@SanPhamID", sanPhamID);
                        cmdBienThe.ExecuteNonQuery();
                    }

                    // 2. Xóa các bản ghi liên quan trong bảng HinhAnhSanPham trước
                    string deleteHinhAnhQuery = "DELETE FROM HinhAnhSanPham WHERE SanPhamID = @SanPhamID";
                    using (SqlCommand cmdHinhAnh = new SqlCommand(deleteHinhAnhQuery, con, transaction))
                    {
                        cmdHinhAnh.Parameters.AddWithValue("@SanPhamID", sanPhamID);
                        cmdHinhAnh.ExecuteNonQuery();
                    }

                    // 3. Sau đó, xóa bản ghi trong bảng SanPham
                    string deleteSanPhamQuery = "DELETE FROM SanPham WHERE SanPhamID = @SanPhamID";
                    using (SqlCommand cmdSanPham = new SqlCommand(deleteSanPhamQuery, con, transaction))
                    {
                        cmdSanPham.Parameters.AddWithValue("@SanPhamID", sanPhamID);
                        int rowsAffected = cmdSanPham.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            transaction.Commit();
                            litProductMessage.Text = "<span style='color:green;'>Xóa sản phẩm và dữ liệu liên quan thành công!</span>";
                        }
                        else
                        {
                            transaction.Rollback();
                            litProductMessage.Text = "<span style='color:red;'>Không tìm thấy sản phẩm để xóa.</span>";
                        }
                        BindProductsGridView();
                    }
                }
                catch (SqlException sqlEx)
                {
                    if (transaction != null)
                    {
                        transaction.Rollback();
                    }
                    litProductMessage.Text = "<span style='color:red;'>Lỗi SQL khi xóa sản phẩm: " + sqlEx.Message + "</span>";
                }
                catch (Exception ex)
                {
                    if (transaction != null)
                    {
                        transaction.Rollback();
                    }
                    litProductMessage.Text = "<span style='color:red;'>Lỗi chung khi xóa sản phẩm: " + ex.Message + "</span>";
                }
            }
        }

        // xoa users
        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string deleteUserQuery = "DELETE FROM dbo.Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(deleteUserQuery, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    try
                    {
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            litUserMessage.Text = "<span style='color:green;'>Xóa người dùng thành công!</span>";
                        }
                        else
                        {
                            litUserMessage.Text = "<span style='color:red;'>Không tìm thấy người dùng để xóa.</span>";
                        }
                        BindUsersGridView(); // Rebind the GridView to show updated data
                    }
                    catch (SqlException sqlEx)
                    {
                        litUserMessage.Text = "<span style='color:red;'>Lỗi SQL khi xóa người dùng: " + sqlEx.Message + "</span>";
                    }
                    catch (Exception ex)
                    {
                        litUserMessage.Text = "<span style='color:red;'>Lỗi chung khi xóa người dùng: " + ex.Message + "</span>";
                    }
                }
            }
        }

        protected void btnAddProductPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AddProduct.aspx"); // Điều hướng đến trang thêm sản phẩm
        }
    }
}