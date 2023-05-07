const mongoose = require('mongoose');
const DB_URL = "mongodb+srv://amaryasser:amaryasser@cluster0.mnexmdn.mongodb.net/test";

const productSchema = mongoose.Schema({
    name:String,
    quantity:Number,
    price:Number,
    productCase:String,
    location:String
})

const Product = mongoose.model('product',productSchema);

    
exports.addProduct= async(name,price,quantity,location,productCase)=>{
    return new Promise(async(resolve,reject)=>{
      await mongoose.connect(DB_URL).then(async()=>{
           let product = new Product({
            name:name,
            price:price,
            quantity:quantity,
            location:location,
            productCase:productCase,
           })

          return product.save();
        }).then(()=>{
                mongoose.disconnect();
                resolve(true);
        }).catch((err)=>{
            mongoose.disconnect();
            reject(err);
        })
    })
}

exports.getProductsFromId = (name,productCase)=>{
    return new Promise(async(resolve,reject)=>{
       await mongoose.connect(DB_URL).then(()=>{
           return Product.findOneAndUpdate({name:name},{productCase:productCase}).then((value)=>{
               if(value )
               {
                mongoose.disconnect();
                resolve(value); 
               }else{
                mongoose.disconnect();
                resolve(false); 
               }
        }).catch((err)=>{
            mongoose.disconnect();
            reject(err);
        });
    })
})}


exports.buy = (name)=>{
    return new Promise(async(resolve,reject)=>{
       await mongoose.connect(DB_URL).then(()=>{
           return Product.findOneAndDelete({name:name}).then((value)=>{
               if(value )
               {
                mongoose.disconnect();
                resolve(value); 
               }else{
                mongoose.disconnect();
                resolve(false); 
               }
        }).catch((err)=>{
            mongoose.disconnect();
            reject(err);
        });
    })
})}


exports.getProducts = ()=>{
    return new Promise(async(resolve,reject)=>{
       await mongoose.connect(DB_URL).then(()=>{
           return Product.find().then((value)=>{
               if(value )
               {
                mongoose.disconnect();
                resolve(value); 
               }else{
                mongoose.disconnect();
                resolve(false); 
               }
        }).catch((err)=>{
            mongoose.disconnect();
            reject(err);
        });
    })
})}

