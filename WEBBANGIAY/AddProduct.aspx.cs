using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WEBBANGIAY
{
    public partial class AddProduct : Page
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
                BindHangSanXuatDropDownList();
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

                    }
                }
            }
            return loaiUser;
        }

        private void BindHangSanXuatDropDownList()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = "SELECT HangSanXuatID, TenHang FROM HangSanXuat ORDER BY TenHang";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        ddlHangSanXuat.DataSource = cmd.ExecuteReader();
                        ddlHangSanXuat.DataTextField = "TenHang";
                        ddlHangSanXuat.DataValueField = "HangSanXuatID";
                        ddlHangSanXuat.DataBind();
                        ddlHangSanXuat.Items.Insert(0, new ListItem("-- Chọn Hãng Sản Xuất --", "0"));
                    }
                    catch (Exception ex)
                    {
                        litMessage.Text = "<span style='color:red;'>Lỗi tải hãng sản xuất.</span>";
                    }
                }
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string tenSanPham = txtTenSanPham.Text.Trim();
                string moTaNgan = txtMoTaNgan.Text.Trim();
                string moTaChiTiet = txtMoTaChiTiet.Text.Trim();
                decimal giaBanLe = Convert.ToDecimal(txtGiaBanLe.Text.Trim());
                int hangSanXuatID = Convert.ToInt32(ddlHangSanXuat.SelectedValue);
                string trangThai = ddlTrangThai.SelectedValue;

                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    string query = @"
                        INSERT INTO SanPham (TenSanPham, MoTaNgan, MoTaChiTiet, GiaBanLe, HangSanXuatID, NgayNhap, TrangThai)
                        VALUES (@TenSanPham, @MoTaNgan, @MoTaChiTiet, @GiaBanLe, @HangSanXuatID, @NgayNhap, @TrangThai)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@TenSanPham", tenSanPham);
                        cmd.Parameters.AddWithValue("@MoTaNgan", moTaNgan);
                        cmd.Parameters.AddWithValue("@MoTaChiTiet", moTaChiTiet);
                        cmd.Parameters.AddWithValue("@GiaBanLe", giaBanLe);
                        cmd.Parameters.AddWithValue("@HangSanXuatID", hangSanXuatID);
                        cmd.Parameters.AddWithValue("@NgayNhap", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TrangThai", trangThai);

                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            litMessage.Text = "<span style='color:green;'>Thêm sản phẩm thành công!</span>";
                            ClearForm();
                        }
                        catch (SqlException sqlEx)
                        {
                            litMessage.Text = "<span style='color:red;'>Lỗi SQL: " + sqlEx.Message + "</span>";
                        }
                        catch (Exception ex)
                        {
                            litMessage.Text = "<span style='color:red;'>Lỗi chung: " + ex.Message + "</span>";
                        }
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin.aspx");
        }

        private void ClearForm()
        {
            txtTenSanPham.Text = "";
            txtMoTaNgan.Text = "";
            txtMoTaChiTiet.Text = "";
            txtGiaBanLe.Text = "";
            ddlHangSanXuat.SelectedValue = "0";
            ddlTrangThai.SelectedValue = "Active";
        }
    }
}