<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WEBBANGIAY._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
       
        .section-header-content {
            text-align: center;
        }

        #aspnetTitle {
            text-align: center;
        }

        .banner-image {
            width: 100%;
            height: auto;
            display: block;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .whats-hot-section {
            padding: 40px 0;
            text-align: center;
        }

        .whats-hot-section h2 {
            font-size: 2.5em;
            margin-bottom: 30px;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .product-item {
            flex: 0 0 calc(25% - 20px);
            max-width: calc(25% - 20px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: #fff;
            text-align: left;
            transition: transform 0.2s ease-in-out;
        }

        .product-item:hover {
            transform: translateY(-5px);
        }

        .product-item img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }

        .product-item-info {
            padding: 15px;
        }

        .product-item-info h3 {
            font-size: 1.2em;
            margin-top: 0;
            margin-bottom: 10px;
            color: #333;
            min-height: 40px;
        }

        .product-item-info p {
            font-size: 0.9em;
            color: #666;
            line-height: 1.4;
            min-height: 60px;
        }

        @media (max-width: 992px) {
            .product-item {
                flex: 0 0 calc(33.33% - 20px);
                max-width: calc(33.33% - 20px);
            }
        }

        @media (max-width: 768px) {
            .product-item {
                flex: 0 0 calc(50% - 20px);
                max-width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .product-item {
                flex: 0 0 calc(100% - 20px);
                max-width: calc(100% - 20px);
            }
        }

        /* CSS cho nút Logout */
        .logout-container {
            text-align: right;
            margin-bottom: 20px;
            margin-top: 20px; 
        }
    </style>

    <main>
        <h1> Website bán giày hàng đầu Việt Nam</h1>
        <div class="logout-container">
            <asp:LinkButton ID="lnkLogout" runat="server" Text="Đăng xuất" OnClick="lnkLogout_Click" CssClass="btn btn-danger" Visible="false"></asp:LinkButton>
        </div>

        <section class="row section-header-content" aria-labelledby="aspnetTitle">
            <img src="Images/banner.jpg" alt="Banner Web Bán Giày" class="banner-image" />
        </section>

        <section class="whats-hot-section">
            <h2>HOT</h2>
            <div class="product-grid">
                <div class="product-item">
                    <img src="Images/hot3.jpg" alt="ADIZERO EVO SL" />
                    <div class="product-item-info">
                        <h3>ADIZERO EVO SL</h3>
                        <p>Cảm giác chân thực. Trong mọi khía cạnh của cuộc sống.</p>
                    </div>
                </div>
                <div class="product-item">
                    <img src="Images/hot2.jpg" alt="Ultraboost 5" />
                    <div class="product-item-info">
                        <h3>Ultraboost 5</h3>
                        <p>Một biểu tượng được cải biên bởi thương hiệu.</p>
                   
                    </div>
                </div>
                <div class="product-item">
                    <img src="Images/hot1.jpg" alt="Real Madrid 25/26 Away Kit" />
                    <div class="product-item-info">
                        <h3>Real Madrid 25/26 Away Kit</h3>
                        <p>Mang sân Bernabeu đến cho họ.</p>
                    </div>
                </div>
                <div class="product-item">
                    <img src="Images/hot0.jpg" alt="Y-3 Fall/Winter 2025" />
                    <div class="product-item-info">
                        <h3>Y-3 Fall/Winter 2025</h3>
                        <p>Thời trang ấn tượng cho mùa thu đông.</p>
                    </div>
                </div>
            </div>
        </section>

    </main>

</asp:Content>