import { handleInput } from "../../script.js";

export function RegisterBarbershop(Interface){
    Interface.Actions.barbershop = {}

    Interface.barbershop = {}

    Interface.barbershop.currentPart = 1;
    Interface.barbershop.currentPartName = "mascara";

    Interface.barbershop.currentPrefix = "M";
    Interface.barbershop.storeUlt = 0;
    Interface.barbershop.selectedColorIndex = 0;
    Interface.barbershop.selectedSecondColorIndex = 0;
    


    Interface.Actions.barbershop.updatePrice = function(data){
        document.querySelector(".barbershop-interface .barbershop-price-text").setAttribute("data-value",data.value)
        $(".barbershop-interface .barbershop-price-text").text(data.value)
    }

    Interface.Actions.barbershop.show = function(data){
        Interface.Actions.barbershop.resetAll();
        $(".barbershop-interface").fadeIn()
        Interface.barbershop.storeUlt = data.ultLoja
        Interface.barbershop.currentPrefix = data.sexo
    }

    Interface.Actions.barbershop.hide = function(){
        $(".barbershop-interface").fadeOut()
        Interface.Actions.barbershop.resetAll();
    }

    Interface.Actions.barbershop.resetAll = function(){
        Interface.Actions.barbershop.reset();
        document.querySelectorAll(".rotate-input")
        .forEach((element,key)=>{
            element.value = 0
            handleInput(element)
        });
        console.log("BOM DIAA",document.querySelector(".barbershop-interface .barbershop-price-text"))
        let defaultValue = 0
        $(".barbershop-interface .barbershop-price-text").text(`${defaultValue.toLocaleString("pt-BR",{ style: "currency", currency: "BRL" })}`)
    }

    Interface.Actions.barbershop.reset = function(){
        $(".barbershop-interface .shop-title").fadeOut();
        $(".barbershop-interface .shop-categorys .shop-categorys-page").fadeOut(0);
        $(".barbershop-interface .shop-products").fadeOut(0);

        $(".barbershop-interface .shop-categorys").fadeIn();
        $(`.barbershop-interface .shop-categorys .shop-categorys-page[page="0"]`).fadeIn();
        $(".barbershop-interface .shop-scroll").fadeIn();
        $(".barbershop-interface .shop-scroll input").val("0");
        
    }

    Interface.Actions.barbershop.resetList = function(){
        $(".barbershop-interface .shop-products-wrapper").html("");
    }

    Interface.Actions.barbershop.selectCloth = function(){
        // this.dataset.id
        $(".barbershop-interface .shop-product-single").removeClass("selected");
        $(this).addClass("selected");
        Interface.barbershop.selectedColorIndex = 0 
        $.post('http://big_modules/barbershopchangecustomization', JSON.stringify({ type: Interface.barbershop.currentPart, id: this.dataset.id }));    
        // $.post('http://big_modules/skishopgetinfo', JSON.stringify({ part: Interface.barbershop.currentPartName }));
    }

    Interface.Actions.barbershop.changecategory = function(data){
        Interface.Actions.barbershop.resetList();
        $(".barbershop-interface .shop-categorys .shop-categorys-page").fadeOut(0);
        $(".barbershop-interface .shop-categorys").fadeOut(0);
        $(".barbershop-interface .shop-scroll").fadeOut(0);

        $(".barbershop-interface .shop-products").fadeIn();
        $(".barbershop-interface .shop-title").fadeIn();
        $(".barbershop-interface .shop-title .shop-text").text(Interface.barbershop.currentPartName.toUpperCase())

        Interface.barbershop.currentPart = data.category

        const barbershopList = document.querySelector(".barbershop-interface .shop-products-wrapper")

        for (let i = 0; i < data.drawa; i++) {
            const div = document.createElement("div")

            div.classList.add("shop-product-single")
            div.classList.add("big-background-b")
            div.classList.add("big-background-border-b")

            div.setAttribute("data-id",i)

            div.onclick = Interface.Actions.barbershop.selectCloth

            const img = document.createElement("img")

            img.setAttribute("src", `${Interface.Config.BarbershopImage}${Interface.barbershop.currentPart}/${Interface.barbershop.currentPrefix}/${i}.jpg`)

            div.appendChild(img)

            barbershopList.appendChild(div);
        }

        $('.barbershop-interface .shop-products').animate({
            scrollTop: 0
        },'fast');
    }

    document.getElementById("barbershop_category_scroll").addEventListener("input",function(element){
        $(".barbershop-interface .shop-categorys .shop-categorys-page").hide("fast");
        $(`.barbershop-interface .shop-categorys .shop-categorys-page[page="${this.value}"]`).fadeIn();
    })

    document.querySelector(".barbershop-interface .return-button")
    .onclick = function(event){
        if($(".barbershop-interface .shop-products").is(":visible")){
            Interface.Actions.barbershop.reset();
        } else {
            Interface.Actions.barbershop.hide();
            $.post("https://big_modules/reset");
        }
    }

    document.querySelectorAll(".barbershop-interface .shop-single-category")
    .forEach((element,key)=>{
        element.onclick = function(event){
            const currentEL = event.currentTarget
            Interface.barbershop.currentPartName = currentEL.dataset.idpart
            $.post('http://big_modules/barbershopchangePart', JSON.stringify({ part: Interface.barbershop.currentPartName }));
        }
    })

    document.querySelectorAll(".barbershop-interface .shop-color-button")
    .forEach((element,key)=>{
        element.onclick = function(){
            // this.dataset.action

            if(this.dataset.action == "add"){
                
                if(this.dataset.mode == "primary"){
                    if(Interface.barbershop.selectedColorIndex >= 64) Interface.barbershop.selectedColorIndex = 0
                    Interface.barbershop.selectedColorIndex = Interface.barbershop.selectedColorIndex + 1
                    $.post("https://big_modules/barbershopchangecolor",
                    JSON.stringify({
                        dataType: Interface.barbershop.currentPart,
                        color: Interface.barbershop.selectedColorIndex,
                        type: 1,
                    }))
                } else {
                    if(Interface.barbershop.selectedColorIndex <= 0) Interface.barbershop.selectedColorIndex = 64
                    Interface.barbershop.selectedColorIndex = Interface.barbershop.selectedColorIndex - 1
                    $.post("https://big_modules/barbershopchangecolor",
                    JSON.stringify({
                        dataType: Interface.barbershop.currentPart,
                        color: Interface.barbershop.selectedColorIndex,
                        type: 2,
                    }))
                }

            } else {

                if(this.dataset.mode == "primary"){
                    if(Interface.barbershop.selectedSecondColorIndex >= 64) Interface.barbershop.selectedSecondColorIndex = 0
                    Interface.barbershop.selectedSecondColorIndex = Interface.barbershop.selectedSecondColorIndex + 1
                    $.post("https://big_modules/barbershopchangecolor",
                    JSON.stringify({
                        dataType: Interface.barbershop.currentPart,
                        color: Interface.barbershop.selectedSecondColorIndex,
                        type: 1,
                    }))
                } else {
                    if(Interface.barbershop.selectedSecondColorIndex <= 0) Interface.barbershop.selectedSecondColorIndex = 64
                    Interface.barbershop.selectedSecondColorIndex = Interface.barbershop.selectedSecondColorIndex - 1
                    $.post("https://big_modules/barbershopchangecolor",
                    JSON.stringify({
                        dataType: Interface.barbershop.currentPart,
                        color: Interface.barbershop.selectedSecondColorIndex,
                        type: 2,
                    }))
                }

            }

           
            
          
        }
    })

    document.querySelector(".barbershop-interface .shop-price-button")
    .onclick = function(){
        const price = document.querySelector(".barbershop-interface .barbershop-price-text").dataset.value
        $.post("https://big_modules/barbershoppayament", JSON.stringify({ price }));
    }
}