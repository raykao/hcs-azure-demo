var express = require('express');
var router = express.Router();
var axios = require('axios');

/* GET home page. */
router.get('/', async function(req, res, next) {
  
  try {
    const response = await axios.get('http://localhost:3000');
    res.render('index', { hostname: response.data.hostname });
  }
  catch (err) {
    const status = err;
    console.log(`Failed Status: ${status}`);
    res.status(status).render('index', { hostname: `failed to get hostname. HTTP Code: ${status}`});
  }
});

module.exports = router;
