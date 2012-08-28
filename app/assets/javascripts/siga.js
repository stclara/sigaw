$(document).ready(function () {	
	
	$('#nav li').hover(
		function () {
			//show its submenu
			$('ul', this).slideDown(100);

		}, 
		function () {
			//hide its submenu
			$('ul', this).slideUp(100);			
		}
	);
	
});

$(function() {
        $.mask.definitions['~'] = "[+-]";
        $("#date").mask("99/99/9999", {autoclear:false});
        $("#date1").mask("99/99/9999", {autoclear:false});
        $("#date2").mask("99/99/9999", {autoclear:false});
        $("#phone").mask("(99) 9999-9999", {autoclear:false});
        $("#phone1").mask("(99) 9999-9999", {autoclear:false});
        $("#phone2").mask("(99) 9999-9999", {autoclear:false});
        $("#phone3").mask("(99) 9999-9999", {autoclear:false});
        $("#phone4").mask("(99) 9999-9999", {autoclear:false});
        $("#phone5").mask("(99) 9999-9999", {autoclear:false});
        $("#phone6").mask("(99) 9999-9999", {autoclear:false});
        $("#phone7").mask("(99) 9999-9999", {autoclear:false});
        $("#phone8").mask("(99) 9999-9999", {autoclear:false});
		$("#cpf").mask("999.999.999-99", {autoclear:false});
		$("#cpf1").mask("999.999.999-99", {autoclear:false});
		$("#cep").mask("99.999-999", {autoclear:false});
		$("#cep1").mask("99.999-999", {autoclear:false});
		$("#cep2").mask("99.999-999", {autoclear:false});
		$("#cep3").mask("99.999-999", {autoclear:false});

        $("input").blur(function() {
            $("#info").html("Unmasked value: " + $(this).mask());
        }).dblclick(function() {
            $(this).unmask();
        });
    });
    
