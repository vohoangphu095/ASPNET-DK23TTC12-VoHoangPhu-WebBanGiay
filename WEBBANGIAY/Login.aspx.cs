using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace WEBBANGIAY
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                string returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrEmpty(returnUrl))
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    // Lấy LoaiUser nếu người dùng đã đăng nhập để điều hướng
                    string username = User.Identity.Name;
                    string loaiUser = GetUserRole(username);
                    if (loaiUser == "admin")
                    {
                        Response.Redirect("~/Admin.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                string connectionString = ConfigurationManager.ConnectionStrings["ShoeStoreDBConnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Truy vấn để lấy cả Username và LoaiUser
                    string query = "SELECT LoaiUser FROM dbo.Users WHERE Username=@Username AND Password=@Password";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);

                        try
                        {
                            con.Open();
                            object result = cmd.ExecuteScalar();

                            if (result != null)
                            {
                                string loaiUser = result.ToString();
                                FormsAuthentication.SetAuthCookie(username, false);

                                if (loaiUser == "admin")
                                {
                                    Response.Redirect("~/Admin.aspx");
                                }
                                else
                                {
                                    string returnUrl = Request.QueryString["ReturnUrl"];
                                    if (!string.IsNullOrEmpty(returnUrl))
                                    {
                                        Response.Redirect(returnUrl);
                                    }
                                    else
                                    {
                                        Response.Redirect("~/Default.aspx");
                                    }
                                }
                            }
                            else
                            {
                                litErrorMessage.Text = "Tên đăng nhập hoặc mật khẩu không đúng.";
                            }
                        }
                        catch (Exception ex)
                        {
                            litErrorMessage.Text = "Đã xảy ra lỗi trong quá trình đăng nhập. Vui lòng thử lại sau.";
                        }
                    }
                }
            }
        }

        // Hàm hỗ trợ để lấy LoaiUser (được sử dụng trong Page_Load nếu người dùng đã xác thực)
        private string GetUserRole(string username)
        {
            string loaiUser = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["ShoeStoreDBConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
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
                    catch (Exception)
                    {
                        // Ghi log lỗi nếu cần
                    }
                }
            }
            return loaiUser;
        }
    }
}