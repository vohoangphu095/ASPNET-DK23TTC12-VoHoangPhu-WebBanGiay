using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data; 
using System.Data.SqlClient;
using System.Web.UI.WebControls; 

namespace WEBBANGAY
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProducts(txtSearch.Text.Trim());
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindProducts(txtSearch.Text.Trim());
        }

        private void BindProducts(string searchTerm)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ShoeStoreDBConnection"].ConnectionString;
            DataTable dtProducts = new DataTable(); // Sử dụng DataTable để đơn giản hóa việc đổ dữ liệu

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string productQuery = @"
                    SELECT
                        sp.SanPhamID,
                        sp.TenSanPham,
                        sp.MoTaNgan,
                        MIN(bts.GiaHienTai) AS GiaHienTai,
                        (SELECT TOP 1 URL FROM HinhAnhSanPham WHERE SanPhamID = sp.SanPhamID ORDER BY LaHinhChinh DESC, ThuTuHienThi ASC) AS HinhAnhURL
                    FROM
                        SanPham sp
                    JOIN
                        BienTheSanPham bts ON sp.SanPhamID = bts.SanPhamID
                    WHERE
                        sp.TenSanPham LIKE @SearchTerm
                    GROUP BY
                        sp.SanPhamID, sp.TenSanPham, sp.MoTaNgan, sp.NgayNhap
                    ORDER BY sp.NgayNhap DESC;";

                using (SqlCommand command = new SqlCommand(productQuery, connection))
                {
                    command.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                    try
                    {
                        connection.Open();
                        SqlDataAdapter da = new SqlDataAdapter(command); // Sử dụng SqlDataAdapter
                        da.Fill(dtProducts); // Đổ dữ liệu trực tiếp vào DataTable

                        if (dtProducts.Rows.Count == 0)
                        {
                            lblErrorMessage.Text = "Không tìm thấy sản phẩm phù hợp.";
                        }
                        else
                        {
                            lblErrorMessage.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblErrorMessage.Text = "Lỗi tải sản phẩm: " + ex.Message;
                    }
                }
            }

            rptProducts.DataSource = dtProducts; 
            rptProducts.DataBind();
        }
    }
    public class Product
    {
        public int SanPhamID { get; set; }
        public string TenSanPham { get; set; }
        public string MoTaNgan { get; set; }
        public decimal GiaHienTai { get; set; }
        public string HinhAnhURL { get; set; }
    }
}