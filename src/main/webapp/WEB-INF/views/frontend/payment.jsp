<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Giỏ hàng</title>
<link rel="shortcut icon" type="image/png"
	href="${classpath}/frontend/images/cart-logo.jpg" />
<link rel="stylesheet" type="text/css"
	href="${classpath}/frontend/css/css.css">
<link rel="stylesheet" type="text/css"
	href="${classpath}/frontend/css/cart.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	function decrement() {
		var input = document.getElementById("quantity");
		if (parseInt(input.value) > 1) {
			input.value = parseInt(input.value) - 1;
		}
	}

	function increment() {
		var input = document.getElementById("quantity");
		input.value = parseInt(input.value) + 1;
	}
	function goBack() {
		// Sử dụng window.history để quay về trang trước đó
		window.history.back();
	}
</script>

</head>
<body>
	<div class="container">
		<!-- header -->

		<jsp:include page="/WEB-INF/views/frontend/layout/header.jsp"></jsp:include>
		<!-- /Menu ngang -->


		<c:choose>
			<c:when test="${totalCartProducts > 0}">
				<!-- main -->
				<form action="${classpath }/cart-view" method="get">
				<div class="main">
					<div class="main-left">
						<div class="dau-muc">
							<div style="margin-right: 300px;">SẢN PHẨM</div>
							<div>GIÁ</div>
							<div>SỐ LƯỢNG</div>
							<div>TẠM TÍNH</div>
						</div>
						<c:forEach var="item" items="${cart.cartProducts }"	varStatus="loop">
						<div class="chi-tiet">
							<div style="margin-top: 30px; margin-right: 10px;" class="delete">
								<a style="text-decoration: none" href="${classpath }/product-cart-delete/${item.productId }" role="button" class="btn btn-secondary">
								<i class="fa-regular fa-circle-xmark"></i>
								</a>
							</div>
							<div class="image">
							<a href="${classpath }/detail/${item.productId }">
								<img src="${classpath}/FileUploads/${item.avatar }">
							</a>
							</div>
							<a style=" text-decoration: none"
							 class="name" href="${classpath }/detail/${item.productId }">
							${item.productName }</a>
							<div class="gia">${item.price }₫</div>
							<div class="so-luong">
								
									<input style="width: 50px" type="number" id="quantity${loop.index}" 
									name="quantity" value="${item.quantity}">
									
							</div>
							<div class="tong">${item.price * item.quantity }₫</div>
						</div>
						</c:forEach>
						<div class="btn">
							<div class="xem-san-pham">
								<button>
									<i class="fa-solid fa-arrow-left"></i> <a href="${classpath}/index" style="text-decoration: none;">TIẾP TỤC
										XEM SẢN PHẨM</a>
								</button>
							</div>
							<div class="update">
								<button onclick="updateCart()"><a	class="add-cart-link">CẬP NHẬT GIỎ HÀNG </a></button>
							</div>
						</div>
					</div>
					<div class="main-right">
						<div class="cong-gio-hang">
							<div class="text">ĐƠN HÀNG CỦA BẠN</div>
						</div>
						<div class="tam-tinh">
							<div>Tạm tính</div>
							<a><fmt:formatNumber value="${totalCartPrice }"
																	minFractionDigits="0"></fmt:formatNumber>₫</a>
						</div>
						<div class="tong">
							<div>Tổng</div>
							<a><fmt:formatNumber value="${totalCartPrice }"
																	minFractionDigits="0"></fmt:formatNumber>₫</a>
						</div>
						<div class="thanh-toan">
							<div class="text">TIẾN HÀNH THANH TOÁN</div>
						</div>
						<div class="phieu-uu-dai">
							<div class="text">
								<i style="color: gray;"
									class="fa-solid fa-tag fa-flip-horizontal"></i> Phiếu ưu đãi
							</div>
						</div>
						<div class="text-box2">
							<input type="text" placeholder="Mã ưu đãi">
						</div>
						<button type="submit">Áp dụng</button>

					</div>
				</div>
				</form>
			</c:when>
			<c:otherwise>
				<div class="row">
					<div class="col-md-12" align="center">
						<div class="form-group mb-4">
						<img style="margin-top: 50px" width="300px" src="https://cdn-icons-png.flaticon.com/512/8164/8164717.png">
							<a href="${classpath }/index" class="btn btn-primary active"
								role="button" aria-pressed="true" style="font-weight: bold; margin-left: 600px; margin-top: 20px"> Back to shop </a>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<!-- /main -->


		<!-- footer -->

		<jsp:include page="/WEB-INF/views/frontend/layout/footer.jsp"></jsp:include>
		<!-- /footer -->
	</div>
	<!-- /container -->
</body>
<script type="text/javascript">
		updateProductQuantity = function(_productId, _quantity) {
			let data = {
				productId : _productId, //lay theo id
				quantity : _quantity
			};

			//$ === jQuery
			jQuery.ajax({
				url : "/update-product-quantity",
				type : "POST",
				contentType : "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json

				success : function(jsonResult) {
					let totalProducts = jsonResult.totalCartProducts; 
					//Viet lai so luong sau khi bam nut -, +
					$("#productQuantity_" + jsonResult.productId).html(jsonResult.newQuantity); 
				},

				error : function(jqXhr, textStatus, errorMessage) {
					alert("An error occur");
				}
			});
		}
	</script>

	<script type="text/javascript">
		function _placeOrder() {
			//javascript object
			let data = {				
				txtName : jQuery("#txtName").val(),
				txtEmail : jQuery("#txtEmail").val(), //Get by Id
				txtMobile : jQuery("#txtMobile").val(),
				txtAddress : jQuery("#txtAddress").val(),
			};
			
			//$ === jQuery
			jQuery.ajax({
				url : "/place-order",
				type : "POST",
				contentType: "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json
				
				success : function(jsonResult) {
					alert(jsonResult.code + ": " + jsonResult.message);
					//$("#placeOrderSuccess").html(jsonResult.message);
				},
				
				error : function(jqXhr, textStatus, errorMessage) {
					alert("An error occur");
				}
			});
		}
	</script>
	
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
   function updateCart() {
      var quantities = [];
      <c:forEach var="item" items="${cart.cartProducts}" varStatus="loop">
         quantities.push({
            productId: "${item.productId}",
            quantity: $("#quantity${loop.index}").val()
         });
      </c:forEach>

      $.ajax({
         url: "/update-cart",
         method: "POST",
         contentType: "application/json",
         data: JSON.stringify(quantities),
         success: function(response) {
            // Handle the response, e.g., update total price, display a message, etc.
         },
         error: function() {
            // Handle errors
         }
      });
   }
</script>
</html>
