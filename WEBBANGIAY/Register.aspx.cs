using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WEBBANGIAY
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            litErrorMessage.Text = "";
            litSuccessMessage.Text = "";

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                litErrorMessage.Text = "Tên đăng nhập và mật khẩu không được để trống.";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ShoeStoreDBConnection"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string checkUserQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                    using (SqlCommand checkCmd = new SqlCommand(checkUserQuery, connection))
                    {
                        checkCmd.Parameters.AddWithValue("@Username", username);
                        int userCount = (int)checkCmd.ExecuteScalar();
                        if (userCount > 0)
                        {
                            litErrorMessage.Text = "Tên đăng nhập này đã tồn tại. Vui lòng chọn tên khác.";
                            return;
                        }
                    }

                    string insertUserQuery = "INSERT INTO Users (Username, Password, LoaiUser) VALUES (@Username, @Password, @LoaiUser)";
                    using (SqlCommand command = new SqlCommand(insertUserQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Password", password);
                        command.Parameters.AddWithValue("@LoaiUser", "Customer");

                        command.ExecuteNonQuery();

                        litSuccessMessage.Text = "Đăng ký tài khoản thành công! Bạn có thể <a href='Login.aspx'>đăng nhập</a> ngay bây giờ.";
                        txtUsername.Text = "";
                        txtPassword.Text = "";
                    }
                }
            }
            catch (SqlException ex)
            {
                litErrorMessage.Text = "Lỗi cơ sở dữ liệu khi đăng ký: " + ex.Message;
            }
            catch (Exception ex)
            {
                litErrorMessage.Text = "Đã xảy ra lỗi không mong muốn: " + ex.Message;
            }
        }
    }
}