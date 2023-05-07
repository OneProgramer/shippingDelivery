const mongoose = require('mongoose');
const DB_URL = "mongodb+srv://amaryasser:amaryasser@cluster0.mnexmdn.mongodb.net/test";

const accountSchema = mongoose.Schema({
    email:String,
    password:String,
    name:String,
    phone:String,
    account:String
})

const Account = mongoose.model('account',accountSchema);


exports.SignUp = (email,password,name,phone,accounts)=>{
    return new Promise(async(resolve,reject)=>{
       await mongoose.connect(DB_URL).then(()=>{
           return Account.findOne({email:email}).then((value)=>{
               if(value)
               {
                mongoose.disconnect();
                resolve(false); 
               }else{
                let account = new Account({
                    name:name,
                    email:email,
                    password:password,
                    phone:phone,
                    account:accounts
                });
               return account.save();
               }
            }).then(()=>{
                mongoose.disconnect();
                resolve(true); 
            }).catch((err)=>{
                mongoose.disconnect();
                reject(err);
            });
        })
    })
}
    

exports.login = (email,password)=>{
    return new Promise(async(resolve,reject)=>{
       await mongoose.connect(DB_URL).then(()=>{
           return Account.findOne({email:email}).then((value)=>{
               if(value && value.password == password)
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
    })
}
    
