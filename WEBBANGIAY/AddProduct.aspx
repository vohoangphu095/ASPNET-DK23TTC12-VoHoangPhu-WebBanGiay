<%@ Page Title="Thêm Sản Phẩm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="WEBBANGIAY.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Thêm Sản Phẩm Mới</h2>
    <div class="form-horizontal">
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtTenSanPham" CssClass="col-md-2 control-label">Tên Sản phẩm</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtTenSanPham" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTenSanPham" CssClass="text-danger" ErrorMessage="Tên sản phẩm là bắt buộc." />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtMoTaNgan" CssClass="col-md-2 control-label">Mô tả ngắn</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtMoTaNgan" TextMode="MultiLine" Rows="3" CssClass="form-control" />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtMoTaChiTiet" CssClass="col-md-2 control-label">Mô tả chi tiết</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtMoTaChiTiet" TextMode="MultiLine" Rows="5" CssClass="form-control" />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtGiaBanLe" CssClass="col-md-2 control-label">Giá Bán Lẻ</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtGiaBanLe" CssClass="form-control" TextMode="Number" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtGiaBanLe" CssClass="text-danger" ErrorMessage="Giá bán lẻ là bắt buộc." />
                <asp:CompareValidator runat="server" ControlToValidate="txtGiaBanLe" Type="Double" Operator="GreaterThanEqual" ValueToCompare="0" CssClass="text-danger" ErrorMessage="Giá phải lớn hơn hoặc bằng 0." />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlHangSanXuat" CssClass="col-md-2 control-label">Hãng Sản Xuất</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList ID="ddlHangSanXuat" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlHangSanXuat" InitialValue="0" CssClass="text-danger" ErrorMessage="Vui lòng chọn hãng sản xuất." />
            </div>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ddlTrangThai" CssClass="col-md-2 control-label">Trạng Thái</asp:Label>
            <div class="col-md-10">
                <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Hoạt Động" Value="Active"></asp:ListItem>
                    <asp:ListItem Text="Ngừng Hoạt Động" Value="Inactive"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" Text="Thêm Sản Phẩm" CssClass="btn btn-success" OnClick="btnAddProduct_Click" />
                <asp:Button runat="server" Text="Hủy" CssClass="btn btn-default" OnClick="btnCancel_Click" CausesValidation="False" />
            </div>
        </div>

        <asp:Literal ID="litMessage" runat="server"></asp:Literal>

    </div>
</asp:Content>