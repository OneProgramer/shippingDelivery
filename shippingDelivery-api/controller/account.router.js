const express = require('express');
const router = express.Router();
const account = require('../model/account.model')


router.post('/login',async(req,res)=>{
   await account.login(req.body.email,req.body.password).then((value)=>{
        value ? res.status(200).json({account:value.account}):res.status(404).json({account:'error'});
    }).catch(()=>{
        res.status(404).json({value:'error'}); 
    });
})

router.post('/signup',async(req,res)=>{

    let email = req.body.email
    let password = req.body.password
    let name = req.body.name
    let phone = req.body.phone
    let accounts = req.body.account

  
    await account.SignUp(email,password,name,phone,accounts).then((value)=>{
         value ? res.status(200).json({value:value}):res.status(404).json({value:'error'});
     }).catch(()=>{
         res.status(404).json({value:'error'}); 
     });
 })



 module.exports = router;