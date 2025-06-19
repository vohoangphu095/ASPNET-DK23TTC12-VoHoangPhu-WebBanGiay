<%@ Page Title="Trang Sản Phẩm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="WEBBANGAY.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #fff;
            transition: transform 0.2s ease-in-out;
            min-height: 350px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-card img {
            max-width: 100%;
            height: 180px;
            object-fit: contain;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .product-card h3 {
            font-size: 1.2em;
            margin-bottom: 5px;
            color: #333;
        }

        .product-card p {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 8px;
            flex-grow: 1;
        }

        .product-card .price {
            font-size: 1.1em;
            font-weight: bold;
            color: #e44d26;
            margin-bottom: 15px;
        }

        .product-card .btn {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9em;
            transition: background-color 0.2s;
            margin-top: auto;
        }

        .product-card .btn:hover {
            background-color: #0056b3;
        }

        .search-container {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-container .search-box {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }

        .search-container .search-button {
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            margin-left: 10px;
            transition: background-color 0.2s;
        }

        .search-container .search-button:hover {
            background-color: #218838;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Các Sản phẩm của chúng tôi</h2>

    <div class="search-container">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Nhập tên sản phẩm..."></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="search-button" OnClick="btnSearch_Click" />
    </div>

    <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red" EnableViewState="false"></asp:Label>

    <asp:Repeater ID="rptProducts" runat="server">
        <HeaderTemplate>
            <div class="product-grid">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="product-card">
                <img src='<%# ResolveUrl(Eval("HinhAnhURL").ToString()) %>' alt='<%# Eval("TenSanPham") %>' />
                <h3><%# Eval("TenSanPham") %></h3>
                <p><%# Eval("MoTaNgan") %></p>
                <p class="price"><%# Eval("GiaHienTai", "{0:N0} VNĐ") %></p>
                <a href="ProductDetail.aspx?id=<%# Eval("SanPhamID") %>" class="btn">Xem chi tiết</a>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
    

</asp:Content>