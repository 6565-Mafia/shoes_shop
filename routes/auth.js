const router = require('express').Router();
const authController = require('../controllers/authControllers');

// Define routes with corresponding controller methods
router.post('/register', authController.createUser); // Get all products
router.post('/login', authController.loginUser); // Get a single product


module.exports = router;