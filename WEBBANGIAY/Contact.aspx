<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WEBBANGIAY.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .map-container {
            position: relative;
            padding-bottom: 56.25%; /* Tỷ lệ 16:9 (chiều cao / chiều rộng) */
            height: 0;
            overflow: hidden;
            max-width: 100%;
            background: #f0f0f0; /* Màu nền dự phòng */
            margin-top: 20px; /* Khoảng cách từ nội dung trên */
            border-radius: 8px; /* Bo góc */
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Đổ bóng nhẹ */
        }

            .map-container iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border: 0;
            }

        .contact-info {
            margin-bottom: 30px;
        }

            .contact-info h3 {
                margin-bottom: 10px;
            }

        address {
            margin-bottom: 15px;
            font-style: normal; /* Đặt lại kiểu chữ nghiêng mặc định của address */
        }

            address abbr {
                margin-right: 5px;
            }
    </style>

    <main aria-labelledby="title">

        <div class="contact-info">
            <h3>Thông tin liên hệ của chúng tôi</h3>
            <address>
                <strong>Địa chỉ:</strong> Số 126 Nguyễn Thiện Thành - Khóm 4, Phường 5, Thành phố Trà Vinh, tỉnh Trà Vinh<br />
                <strong>Điện thoại:</strong> 084 66 000 99<br />
                <strong>Email Hỗ trợ:</strong> <a href="mailto:Support@example.com">Support@example.com</a><br />
                <strong>Email Marketing:</strong> <a href="mailto:Marketing@example.com">Marketing@example.com</a>
            </address>
        </div>

        <h3>Vị trí của chúng tôi trên bản đồ</h3>
        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1964.839070868779!2d106.34789547514304!3d9.943015093786807!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a9c3330661ffc7%3A0x7d6a7e0c0b3d6a7d!2zMTI2IE5ndXnhu4VuIFRoaeG7h24gVGjDoG5oLCBQaMaw4buduZyA1LCBUciBhIFbDrW5oLCBUcuOgIFbDrW5oLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1718712933994!5m2!1svi!2s"
                width="600" height="450" style="border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </main>
</asp:Content>
