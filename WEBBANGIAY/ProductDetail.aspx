<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="WEBBANGIAY.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-detail-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            padding: 20px;
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .product-image-section {
            flex: 1;
            min-width: 300px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .product-image-section img {
                max-width: 100%;
                height: auto;
                max-height: 400px;
                object-fit: contain;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

        .product-info-section {
            flex: 2;
            min-width: 400px;
        }

            .product-info-section h2 {
                font-size: 2.2em;
                color: #333;
                margin-bottom: 10px;
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
            }

        .price {
            font-size: 1.8em;
            font-weight: bold;
            color: #e44d26;
            margin-bottom: 20px;
        }

        .description-short {
            font-size: 1.1em;
            color: #555;
            margin-bottom: 15px;
            line-height: 1.6;
        }

        .description-long {
            font-size: 1em;
            color: #666;
            line-height: 1.6;
            margin-top: 20px;
            border-top: 1px dashed #eee;
            padding-top: 20px;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 50px;
            font-size: 1.2em;
        }

        .back-button-container {
            text-align: center;
            margin: 30px auto;
            max-width: 1200px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlProductDetail" runat="server" Visible="false">
        <div class="product-detail-container">
            <div class="product-image-section">
                <asp:Image ID="imgProduct" runat="server" />
            </div>
            <div class="product-info-section">
                <h2 id="productNameHeading">
                    <asp:Literal ID="litProductName" runat="server"></asp:Literal></h2>
                <p class="price">
                    <asp:Literal ID="litProductPrice" runat="server"></asp:Literal></p>
                <p class="description-short">
                    <asp:Literal ID="litProductDescriptionShort" runat="server"></asp:Literal></p>
                <p class="description-long">
                    <asp:Literal ID="litProductDescriptionLong" runat="server"></asp:Literal></p>

            </div>
        </div>
    </asp:Panel>

    <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>

    <div class="back-button-container">
        <a href="Products.aspx" class="btn btn-primary btn-lg">
            <i class="fa fa-arrow-left"></i>Trở về trang Sản phẩm
        </a>
    </div>
</asp:Content>
