<%@ page import="com.cis.ecart.model.Product" %>
<%@ page import="com.cis.ecart.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cis.ecart.utility.DBConnection" %>
<%@ page import="com.cis.ecart.model.Cart" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cis.ecart.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }
    ProductDao pd = new ProductDao(DBConnection.createDBConnection());
    List<Product> products = pd.getAllProducts();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<%@include file="/includes/head.jsp"%>
<body>
    <%@include file="/includes/navbar.jsp"  %>
<%--    <jsp:include page="includes/navbar.jsp" flush="true">--%>
<%--        <jsp:param name="auth" value="${auth}"/>--%>
<%--    </jsp:include>--%>
<h1><%=request.getParameter("auth") %> value</h1>
    <div class="container">
        <div class="card-header my-3">All Products</div>
        <div class="row">
            <%
                if (!products.isEmpty()) {
                    for (Product p : products) {
            %>
            <div class="col-md-3 my-3">
                <div class="card w-100">
                    <img class="card-img-top" src="product-image/<%=p.getImage() %>"
                         alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title"><%=p.getName() %></h5>
                        <h6 class="price">Price: $<%=p.getPrice() %></h6>
                        <h6 class="category">Category: <%=p.getCategory() %></h6>
                        <div class="mt-3 d-flex justify-content-between">
                            <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a> <a
                                class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
                    out.println("There is no proucts");
                }
            %>
        </div>
    </div>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>