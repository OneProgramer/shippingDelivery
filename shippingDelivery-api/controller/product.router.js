const express = require('express');
const router = express.Router();
const productModel = require('../model/product.model');



router.get('/',async(req,res)=>{
    await productModel.getProducts().then((value)=>{
        res.status(200).json({value:value});
    }).catch(()=>{
        res.status(404).json({value:'error'});
    })
})

router.post('/',async(req,res)=>{
    let name = req.body.name
    let price = req.body.price
    let quantity = req.body.quantity
    let location = req.body.location
    let productCase = req.body.productCase

  await  productModel.addProduct(name,price,quantity,location,productCase).then((value)=>{
        if(value == true)
        {
            res.status(200).json({value:value});
        }else{
            res.status(200).json({value:false});
        }
    }).catch(()=>{
        res.status(404).json({value:'error'});
    })
})


router.post('/id',async(req,res)=>{
   await productModel.getProductsFromId(req.body.name,req.body.productCase).then((value)=>{
    if(value)
    {
        res.status(200).json({value:true});
    }else{
        res.status(200).json({value:false});                             
    }
    }).catch((err)=>{
        console.log(err)
        res.status(404).json({value:'error'});
    })
})

router.post('/buy',async(req,res)=>{
    await productModel.buy(req.body.name).then((value)=>{
     if(value)
     {
         res.status(200).json({value:true});
     }else{
         res.status(200).json({value:false});                             
     }
     }).catch((err)=>{
         console.log(err)
         res.status(404).json({value:'error'});
     })
 })
module.exports = router;
