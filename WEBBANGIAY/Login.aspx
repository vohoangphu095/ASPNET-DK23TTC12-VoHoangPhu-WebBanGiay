<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WEBBANGIAY.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .login-container {
            max-width: 400px;
            margin: 80px auto;
            padding: 35px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            background-color: #ffffff;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 30px;
            color: #343a40;
            font-size: 2.2em;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
            font-size: 0.95em;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1em;
            transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

        .form-control:focus {
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.15em;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-login:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .error-message {
            color: #dc3545;
            margin-top: 15px;
            font-weight: bold;
            font-size: 0.9em;
        }

        .register-link {
            margin-top: 25px;
            font-size: 0.95em;
            color: #6c757d;
        }

        .register-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>

    <div class="login-container">
        <h2>Đăng nhập</h2>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error-message" HeaderText="Vui lòng kiểm tra các lỗi sau:" />
        
        <div class="error-message">
            <asp:Literal ID="litErrorMessage" runat="server"></asp:Literal>
        </div>

        <div class="form-group">
            <label for="<%= txtUsername.ClientID %>">Tên đăng nhập:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" PlaceHolder="Nhập tên đăng nhập"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Tên đăng nhập không được để trống." Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="<%= txtPassword.ClientID %>">Mật khẩu:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" PlaceHolder="Nhập mật khẩu"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Mật khẩu không được để trống." Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn-login" OnClick="btnLogin_Click" />

        <div class="register-link">
            Chưa có tài khoản? <a href="Register.aspx">Đăng ký ngay</a>
        </div>
    </div>
</asp:Content>