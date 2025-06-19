<%@ Page Title="Trang Quản Trị" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WEBBANGIAY.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Chào mừng đến trang Quản trị</h1>
        
    </div>

    <div class="row">
        <div class="col-md-12">
            <h3>Danh sách Sản phẩm</h3>
             <div style="margin-bottom: 20px;">
                <asp:Button ID="btnAddProductPage" runat="server" Text="Thêm Sản Phẩm Mới" 
                            CssClass="btn btn-primary" OnClick="btnAddProductPage_Click" />
            </div>
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="SanPhamID" 
                OnRowDeleting="gvProducts_RowDeleting" 
                CssClass="table table-bordered table-striped"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvProducts_PageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="SanPhamID" HeaderText="ID" ReadOnly="True" SortExpression="SanPhamID" />
                    <asp:BoundField DataField="TenSanPham" HeaderText="Tên Sản phẩm" SortExpression="TenSanPham" />
                    <asp:BoundField DataField="MoTaNgan" HeaderText="Mô tả ngắn" SortExpression="MoTaNgan" />
                    <asp:BoundField DataField="MoTaChiTiet" HeaderText="Mô tả chi tiết" SortExpression="MoTaChiTiet" />
                    <asp:BoundField DataField="GiaBanLe" HeaderText="Giá" SortExpression="GiaBanLe" DataFormatString="{0:N0} VNĐ" />
                    <asp:BoundField DataField="HangSanXuatID" HeaderText="ID Hãng" SortExpression="HangSanXuatID" />
                    <asp:BoundField DataField="NgayNhap" HeaderText="Ngày Nhập" SortExpression="NgayNhap" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="TrangThai" HeaderText="Trạng Thái" SortExpression="TrangThai" />
                    
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Xóa" HeaderText="Xóa" ControlStyle-CssClass="btn btn-danger btn-sm" />
                </Columns>               
                <PagerStyle CssClass="pagination-ys" HorizontalAlign="Center" />
            </asp:GridView>
            <asp:Literal ID="litProductMessage" runat="server"></asp:Literal>
        </div>
    </div>
</asp:Content>