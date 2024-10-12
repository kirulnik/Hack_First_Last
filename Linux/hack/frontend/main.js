$('.login').click(function()
{
	$('.popup_bg').fadeIn(600);
});

$('.close-popup').click(function()
{
	$('.popup_bg').fadeOut(600);
});

$('.popup_bg').click(function (e) {
  if (!$(e.target).closest(".popup").length) {
    $('.popup_bg').fadeOut(600);
  }
});

function lkInfo() {
    if ($.cookie("token")) {
        $.ajax({
        url: 'http://' + window.location.hostname + ':8000/getInfoLk',
        method: 'get',
        dataType: 'json',
        data: {"token": $.cookie("token")},
        success: function(data){
            var flag = "";
            var fio = data["fio"];
            if (fio != "Victor") {
                flag = data["position"];
            } else {
                flag = "flag={Chef Claude Monet}";
            }
            $("#fioLk").text("ФИО: " + data["fio"]);
            $("#idLk").text("ID: " + data["id"]);
            $("#positionLk").text("Должность: " + flag);
        },
        error: function(xhr){
             $("#fioLk").text("error");
             $("#idLk").text("error");
             $("#positionLk").text("error");
        }
        })
    }
    else window.location.href = "index.html";
}


function openForm() {
	document.getElementById("myForm").style.display = "block";
}

function closeForm() {
	document.getElementById("myForm").style.display = "none";
}

$("#formAuth").submit(function(e) {
  e.preventDefault();
  $.ajax({
	url: 'http://' + window.location.hostname + ':8000/login',
	method: 'post',
	dataType: 'json',
	data: $(this).serialize(),
	success: function(data){
		$.cookie("token", data["token"]);
	    window.location.href = "lk.html";
	},
	error: function(xhr){
	    alert("Эх... Данные неверные :(");
	}
});
});

$("#orderFormContent").submit(function(o) {
	o.preventDefault()
	$.ajax({
		url: 'http://' + window.location.hostname + ':8000/order',
		method: 'post',
		dataType: 'json',
		data: $(this).serialize(),
		success: function(data){
			alert("Ваш заказ готов!");
		}
	});
});

document.getElementById('orderFormContent').addEventListener('submit', function(event) {
    event.preventDefault();
    document.getElementById('orderForm').style.display = 'none';
    document.getElementById('orderConfirmation').style.display = 'block';
});
