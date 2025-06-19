using System;
using System.Web.Security; // Thêm namespace này
using System.Web.UI;

namespace WEBBANGIAY
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (User.Identity.IsAuthenticated)
            {
                lnkLogout.Visible = true; // Hiển thị nút Đăng xuất nếu đã đăng nhập
            }
            else
            {
                lnkLogout.Visible = false; // Ẩn nút Đăng xuất nếu chưa đăng nhập
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut(); // Đăng xuất người dùng
            Response.Redirect("~/Login.aspx"); // Chuyển hướng về trang đăng nhập sau khi đăng xuất
            // Hoặc Response.Redirect("~/Default.aspx"); nếu bạn muốn chuyển về trang chủ
        }
    }
}