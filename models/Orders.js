//const mongoose=require(`mongoose`)
//const OrderSchema = new mongoose.Schema({
//userId:{type:String,required:true},
//CustomerId:{type:String,required:true},
//ProductId:{type:mongoose.Schema.Types.ObjectId,ref:"Product"},
//quantity:{type:Number,required:true}
//subtotal:{type:Number,required:true}
//delivery_status:{type:String,required:true,default:"pending"}
//payment_status:{type:String,required:true}
//total:{type:Number,required:true}
//
//
//}; {timestamp:true});
//module.exports=mongoose.model("Order",OrderSchema)
const mongoose = require('mongoose');

const OrderSchema = new mongoose.Schema({
    userId: { type: String, required: true },
    customerId: { type: String, required: true },
    productId: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
    quantity: { type: Number, required: true },
    subtotal: { type: Number, required: true },
    delivery_status: { type: String, required: true, default: "pending" },
    payment_status: { type: String, required: true },
    total: { type: Number, required: true }
}, { timestamps: true }); // Note the correct placement of timestamps

module.exports = mongoose.model("Order", OrderSchema);
