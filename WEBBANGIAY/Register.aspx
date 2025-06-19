<%@ Page Title="Đăng ký tài khoản" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WEBBANGIAY.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Giữ lại một ít CSS để dễ nhìn, bạn có thể xóa hết nếu muốn "tối giản" hơn nữa */
        .register-container {
            max-width: 400px;
            margin: 80px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-control {
            width: calc(100% - 22px); /* Kích thước bao gồm padding */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-register {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
        .success-message {
            color: green;
            margin-top: 10px;
        }
    </style>

    <div class="register-container">
        <h2>Đăng ký tài khoản mới</h2>
        
        <div class="error-message">
            <asp:Literal ID="litErrorMessage" runat="server"></asp:Literal>
        </div>
        <div class="success-message">
            <asp:Literal ID="litSuccessMessage" runat="server"></asp:Literal>
        </div>

        <div class="form-group">
            <label for="<%= txtUsername.ClientID %>">Tên đăng nhập:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" PlaceHolder="Nhập tên đăng nhập"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="<%= txtPassword.ClientID %>">Mật khẩu:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" PlaceHolder="Nhập mật khẩu"></asp:TextBox>
        </div>

        <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" CssClass="btn-register" OnClick="btnRegister_Click" />

        <div style="margin-top: 15px;">
            Đã có tài khoản? <a href="Login.aspx">Đăng nhập</a>
        </div>
    </div>
</asp:Content>