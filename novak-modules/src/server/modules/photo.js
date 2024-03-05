const fs = require("fs");

function recursiveMKDIR(path){
    fs.mkdir(path,{ recursive: true },(err)=>{
        if(err) throw err;
    })
}

exports("recursiveMKDIR",recursiveMKDIR)