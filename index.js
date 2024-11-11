
const express = require('express');
const app = express();
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const cors = require('cors');  
const productRoute = require('./routes/products');
const authRoute = require('./routes/auth');
const userRoute = require('./routes/users');
const ordersRoute = require('./routes/orders');
const cartRoute = require('./routes/cart');
const port = 3005;
dotenv.config();

app.use(cors());
//const stripe =Stripe(process.env.STRIPE_SECRET);
mongoose.connect(process.env.MONGO_URL)
    .then(() => console.log("db connected"))
    .catch((err) => console.log(err));


// Middleware to parse JSON and URL-encoded data
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));

// Route for product-related requests
app.use('/api/', authRoute);
app.use('/api/products', productRoute);
//app.use('/api/', authRoute);
app.use('/api/users', userRoute);
app.use('/api/orders', ordersRoute);
app.use('/api/cart', cartRoute);

app.listen(process.env.PORT || port, () => {
    console.log(`Example app listening on port ${process.env.PORT || port}!`);
});

