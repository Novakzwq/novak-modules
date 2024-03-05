import { handleInput } from "../../script.js";

export function RegisterSkinshop(Interface){
    Interface.Actions.skinshop = {}

    Interface.skinshop = {}

    Interface.skinshop.currentPart = 1;
    Interface.skinshop.currentPartName = "mascara";

    Interface.skinshop.currentColor = 1;
    Interface.skinshop.currentPrefix = "Male";
    Interface.skinshop.selectedColorIndex = 0;

    Interface.Actions.skinshop.updatePrice = function(data){
        document.querySelector(".skinshop-interface .skinshop-price-text").setAttribute("data-value",data.value)
        $(".skinshop-interface .skinshop-price-text").text(data.value)
    }

    Interface.Actions.skinshop.show = function(data){
        Interface.Actions.skinshop.resetAll();
        $(".skinshop-interface").fadeIn()
        Interface.skinshop.currentPrefix = data.sexo
        console.log(data.sexo)
    }

    Interface.Actions.skinshop.hide = function(){
        $(".skinshop-interface").fadeOut()
        Interface.Actions.skinshop.resetAll();
    }

    Interface.Actions.skinshop.resetAll = function(){
        Interface.Actions.skinshop.reset();
        document.querySelectorAll(".rotate-input")
        .forEach((element,key)=>{
            element.value = 0
            handleInput(element)
        });
        let defaultValue = 0
        $(".skinshop-interface .skinshop-price-text").text(`${defaultValue.toLocaleString("pt-BR",{ style: "currency", currency: "BRL" })}`)
    }

    Interface.Actions.skinshop.reset = function(){
        $(".skinshop-interface .shop-title").fadeOut();
        $(".skinshop-interface .shop-categorys .shop-categorys-page").fadeOut(0);
        $(".skinshop-interface .shop-products").fadeOut(0);

        $(".skinshop-interface .shop-categorys").fadeIn();
        $(`.skinshop-interface .shop-categorys .shop-categorys-page[page="0"]`).fadeIn();
        $(".skinshop-interface .shop-scroll").fadeIn();
        $(".skinshop-interface .shop-scroll input").val("0");
        
    }

    Interface.Actions.skinshop.resetList = function(){
        $(".skinshop-interface .shop-products-wrapper").html("");
    }

    Interface.Actions.skinshop.selectCloth = function(){
        // this.dataset.id
        $(".skinshop-interface .shop-product-single").removeClass("selected");
        $(this).addClass("selected");
        Interface.skinshop.selectedColorIndex = 0
        document.querySelector(".skinshop-interface .shop-color-selected img")
        .setAttribute("src",`${Interface.Config.SkinshopImage}${Interface.skinshop.currentPart}/${Interface.skinshop.currentPrefix}/${this.dataset.id}_${Interface.skinshop.selectedColorIndex}.jpg`)
        $.post('http://big_modules/skinshopchangecustomization', JSON.stringify({ type: Interface.skinshop.currentPart, id: this.dataset.id, color: Interface.skinshop.selectedColorIndex }));    
        $.post('http://big_modules/skishopgetinfo', JSON.stringify({ part: Interface.skinshop.currentPartName }));
    }

    Interface.Actions.skinshop.changecategory = function(data){
        Interface.Actions.skinshop.resetList();
        $(".skinshop-interface .shop-categorys .shop-categorys-page").fadeOut(0);
        $(".skinshop-interface .shop-categorys").fadeOut(0);
        $(".skinshop-interface .shop-scroll").fadeOut(0);

        $(".skinshop-interface .shop-products").fadeIn();
        $(".skinshop-interface .shop-title").fadeIn();
        $(".skinshop-interface .shop-title .shop-text").text(Interface.skinshop.currentPartName.toUpperCase())

        Interface.skinshop.currentPart = data.category

        const skinShopList = document.querySelector(".skinshop-interface .shop-products-wrapper")

        for (let i = 0; i < data.drawa; i++) {
            const div = document.createElement("div")

            div.classList.add("shop-product-single")
            div.classList.add("big-background-b")
            div.classList.add("big-background-border-b")

            div.setAttribute("data-id",i)

            div.onclick = Interface.Actions.skinshop.selectCloth

            const img = document.createElement("img")

            console.log(Interface.skinshop.currentPart,Interface.skinshop.currentPrefix,i)

            img.setAttribute("src",`${Interface.Config.SkinshopImage}${Interface.skinshop.currentPart}/${Interface.skinshop.currentPrefix}/${i}_0.jpg`)

            div.appendChild(img)

            skinShopList.appendChild(div);
        }

        $('.skinshop-interface .shop-products').animate({
            scrollTop: 0
        },'fast');
    }

    document.getElementById("skinshop_category_scroll").addEventListener("input",function(element){
        $(".skinshop-interface .shop-categorys .shop-categorys-page").hide("fast");
        $(`.skinshop-interface .shop-categorys .shop-categorys-page[page="${this.value}"]`).fadeIn();
    })

    document.querySelector(".skinshop-interface .return-button")
    .onclick = function(event){
        if($(".skinshop-interface .shop-products").is(":visible")){
            Interface.Actions.skinshop.reset();
        } else {
            Interface.Actions.skinshop.hide();
            $.post("https://big_modules/reset");
        }
    }

    document.querySelectorAll(".skinshop-interface .shop-single-category")
    .forEach((element,key)=>{
        element.onclick = function(event){
            const currentEL = event.currentTarget
            Interface.skinshop.currentPartName = currentEL.dataset.idpart
            $.post('http://big_modules/skinshopchangePart', JSON.stringify({ part: Interface.skinshop.currentPartName }));
        }
    })

    document.querySelectorAll(".skinshop-interface .shop-color-button")
    .forEach((element,key)=>{
        element.onclick = function(){
            // this.dataset.action
            $.post("https://big_modules/skinshopchangecolor",
            JSON.stringify({ action: this.dataset.action }),
            function (data, textStatus, jqXHR) {
                console.log(data.color)
                
                Interface.skinshop.selectedColorIndex = parseInt(data.color)

                document.querySelector(".skinshop-interface .shop-color-selected img")
                .setAttribute("src",`${Interface.Config.SkinshopImage}${Interface.skinshop.currentPart}/${Interface.skinshop.currentPrefix}/${data.part}_${data.color}.jpg`)

                // document.querySelector(".skinshop-interface .shop-color-selected img")
                // .setAttribute("src",`./assets/clothes/${Interface.skinshop.currentPrefix.toLowerCase()}/${Interface.skinshop.currentPart}/${this.dataset.id}.png`)
            });
        }
    })

    document.querySelector(".skinshop-interface .shop-price-button")
    .onclick = function(){
        const price = document.querySelector(".skinshop-interface .skinshop-price-text").dataset.value
        $.post("https://big_modules/skinshoppayament", JSON.stringify({ price }));
    }
}