const express = require('express');
const app = express();
const account = require('./controller/account.router');
const product = require('./controller/product.router');
const cors = require('cors');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended:true}));



app.use('/account',account);
app.use('/product',product);


let port = process.env.PORT || '3000';
app.listen(port,()=>{console.log(`running in port ${port}`)});