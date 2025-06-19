using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WEBBANGIAY
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int sanPhamID;
                    if (int.TryParse(Request.QueryString["id"], out sanPhamID))
                    {
                        LoadProductDetails(sanPhamID);
                    }
                    else
                    {
                        lblErrorMessage.Text = "ID sản phẩm không hợp lệ.";
                        pnlProductDetail.Visible = false;
                    }
                }
                else
                {
                    lblErrorMessage.Text = "Không có ID sản phẩm được cung cấp.";
                    pnlProductDetail.Visible = false;
                }
            }
        }

        private void LoadProductDetails(int sanPhamID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ShoeStoreDBConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        sp.SanPhamID,
                        sp.TenSanPham,
                        sp.MoTaNgan,
                        sp.MoTaChiTiet,
                        MIN(bts.GiaHienTai) AS GiaHienTai,
                        (SELECT TOP 1 URL FROM HinhAnhSanPham WHERE SanPhamID = sp.SanPhamID ORDER BY LaHinhChinh DESC, ThuTuHienThi ASC) AS HinhAnhURL
                    FROM
                        SanPham sp
                    JOIN
                        BienTheSanPham bts ON sp.SanPhamID = bts.SanPhamID
                    WHERE
                        sp.SanPhamID = @SanPhamID
                    GROUP BY
                        sp.SanPhamID,
                        sp.TenSanPham,
                        sp.MoTaNgan,
                        sp.MoTaChiTiet;";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@SanPhamID", sanPhamID);

                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            pnlProductDetail.Visible = true;
                            lblErrorMessage.Text = "";

                            litProductName.Text = reader["TenSanPham"].ToString();
                            litProductPrice.Text = Convert.ToDecimal(reader["GiaHienTai"]).ToString("N0") + " VNĐ";
                            litProductDescriptionShort.Text = reader["MoTaNgan"].ToString();
                            litProductDescriptionLong.Text = reader["MoTaChiTiet"].ToString();

                            string imageUrl = reader["HinhAnhURL"] != DBNull.Value ? reader["HinhAnhURL"].ToString() : "~/Images/products/default_shoe.jpg";
                            imgProduct.ImageUrl = imageUrl;
                            imgProduct.AlternateText = reader["TenSanPham"].ToString();
                        }
                        else
                        {
                            lblErrorMessage.Text = "Không tìm thấy sản phẩm với ID này.";
                            pnlProductDetail.Visible = false;
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Lỗi khi tải chi tiết sản phẩm: " + ex.Message);
                        lblErrorMessage.Text = "Đã xảy ra lỗi khi tải chi tiết sản phẩm. Vui lòng thử lại sau. (" + ex.Message + ")";
                        pnlProductDetail.Visible = false;
                    }
                }
            }
        }
    }
}