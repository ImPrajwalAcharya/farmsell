const String fruitList = """
[
	{
		"name":"Banana",
		"photo_url":"https://jooinn.com/images/banana-7.jpg",
		"unit":"kg",
		"id":1,
    "description" : "A long, curved fruit known as a banana grows on a tropical perennial herb. When fully ripe, it is typically yellow with smooth, creamy flesh. Potassium, vitamin B6, and vitamin C are all present in bananas in good amounts. They are frequently consumed as snacks or added to smoothies, baked goods, and other dishes. They are typically accessible all year long. Additionally, they are a well-known source of energy and are used in many different cuisines. They also have a slight sweetness to them by nature. They come in a variety of shapes and sizes, some with a higher or lower sugar content and others with a firmer or softer texture."

	},
	{
		"name":"Orange",
		"photo_url":"https://media.istockphoto.com/photos/orange-picture-id185284489?k=6&m=185284489&s=612x612&w=0&h=x_w4oMnanMTQ5KtSNjSNDdiVaSrlxM4om-3PQTIzFaY=",
		"unit":"kg",
		"id":2,
    "description" : "A citrus fruit known as an orange typically has a round shape, a bright orange exterior, and juicy, sweet-tart interior flesh. It contains a lot of nutrients, including vitamin C. Oranges can be used in baking and cooking in addition to being consumed as a snack or made into juice. The fruit is typically in season during the winter months and is typically picked and eaten when ripe. Orange peel is frequently used to produce essential oils and zest."
	
	},

	{
		"name":"Black Grapes",
		"photo_url":"https://i5.walmartimages.com/asr/1ba832cc-ba4b-4ad1-97df-9bb40f25f7ae_2.1067c57d4630bbc11557ab28a24f02cd.jpeg",
		"unit":"kg",
		"id":4,
		"description" : "Usually dark purple or black in color, black grapes are a particular variety of grape. In comparison to green or red grapes, they are typically sweeter and have a stronger flavor. In addition to being frequently used to make wine, juice, and jams, they can also be cooked with or eaten raw as a snack. Additionally rich in antioxidants and other nutrients are black grapes."
	},
	{
		"name":"Pineapple",
		"photo_url":"https://www.dietandi.com/wp-content/uploads/2014/02/slice-of-pineapple.jpg",
		"unit":"kg",
		"id":5,
		"description" : "The tropical fruit known as the pineapple is distinguished by its distinctive, spiky exterior and its sweet, juicy flesh. The fruit is usually oblong or circular in shape and is actually composed of several smaller fruits that have fused together. Vitamin C, B-Complex, Vitamin A, and minerals like calcium and manganese are all abundant in pineapple. Additionally, it is a good source of dietary fiber and the enzyme bromelain, which aids in digestion. In addition to being frequently consumed fresh, pineapple can also be canned, cooked, or used to produce juice or other food items."
	},
	{
		"name":"Apple",
		"photo_url":"http://dreamicus.com/data/apple/apple-05.jpg",
		"unit":"kg",
		"id":6,
		"description" : "An apple is a round fruit that typically has a red, green, or yellow skin and a white, crisp inner flesh. It belongs to the rose family and can be found on trees in many different climates all over the world. Apples are a good source of dietary fiber and vitamin C, and they also contain phytochemicals and antioxidants that may be good for your health. They can be used to make juice, cider, or other foods, or they can be cooked or eaten raw. There are numerous varieties of apples, each with a distinctive flavor, texture, and color. Golden Delicious, Red Delicious, Granny Smith, Gala, and Fuji are a few of the most popular varieties."
	},
	{
		"name":"Strawberry",
		"photo_url":"https://images6.fanpop.com/image/photos/35200000/Juicy-Red-Strawberries-strawberries-35204054-1920-1200.jpg",
		"unit":"kg",
		"id":7,
    "description" : "A strawberry is a tiny, juicy, red fruit that belongs to the rose family. It smells distinctively and has a sweet flavor. The fruit can be used to make jams, jellies, syrups, and other food products in addition to being consumed fresh. In addition to being low in calories and high in vitamin C, strawberries also have phytochemicals, antioxidants, potassium, and folate that may be beneficial for your health."
		
	},
	{
		"name":"Mango",
		"photo_url":"https://orders.blackriverproduce.com/media/images/items/MANGOS.jpg",
		"unit":"kg",
		"id":8,
    "description" : "The Southeast Asian tropical fruit known as the mango is prized for its sweet, juicy, and slightly fibrous flesh. The fruit typically has an oblong or oval shape and a smooth, thin skin that can be green, yellow, or red in color. Mangoes have a large seed in the center and flesh that can be yellow, orange, or red. Mangoes are a good source of dietary fiber, vitamins C, A, and B6."
		
	},

	{
		"name":"Papaya",
		"photo_url":"https://www.pngmart.com/image/25458/png/25457",
		"unit":"kg",
		"id":10,
		"description" : "Papaya is a tropical fruit that is native to Central America and Mexico, and it is known for its sweet, juicy flesh and rich, orange color. It is typically oblong or round in shape, and it has a smooth, thin skin that ranges in color from green to yellow to orange, depending on ripeness. The fruit has a large central seed compartment that is inedible, the flesh surrounding it can be eaten raw, cooked or used in a variety of food products."
	}
  ]
""";

const String vegetablesList = """
[
  
  {
		"name":"Cabbage",
		"photo_url":"https://gardeningtips.in/wp-content/uploads/2021/02/cabbage-2058826_1920-1068x711.jpg",
		"unit":"kg",
		"id":11,
    "description" : "Cabbage is a leafy vegetable that is part of the cruciferous family, which also includes broccoli, cauliflower, and Brussels sprouts. It is typically round or oval in shape and can vary in color from green to red, purple, and even white. Cabbage has tightly packed leaves that are firm to the touch and have a slightly bitter taste."
	},
	{
		"name":"Capsicum",
		"photo_url":"https://s3.amazonaws.com/images.ecwid.com/images/26225026/1365712435.jpg",
		"unit":"kg",
		"id":12,
		"description" : "Capsicum, also known as bell pepper or sweet pepper, is a vegetable that is part of the nightshade family, which also includes tomatoes and eggplants. It is typically bell-shaped and comes in a variety of colors, including green, red, yellow, orange, and purple. Capsicum has a sweet and slightly bitter taste."
	},
	{
		"name":"Lemon",
		"photo_url":"https://pngimg.com/uploads/lemon/lemon_PNG25198.png",
		"unit":"kg",
		"id":13,
    "description" : "A lemon is a small, round citrus fruit that has a bright yellow, slightly bumpy skin and a sour, acidic pulp. Lemons are typically used for their juice and zest, which is used to add flavor to a wide variety of dishes, drinks, and desserts. Lemons are a good source of Vitamin C and contain other beneficial compounds such as flavonoids, citric acid and limonoids. The juice is commonly used as a flavoring agent in many foods and drinks, and the zest can also be used to add flavor to recipes. Lemons are also known for their cleaning and deodorizing properties and are used in cleaning products and as a natural air freshener."
		
	},
	{
		"name":"Garlic",
		"photo_url":"http://atlantablackstar.com/wp-content/uploads/2013/09/garlic.jpg",
		"unit":"kg",
		"id":14,
		//"price": 20.99
    "description" : "Garlic is a perennial herb that is closely related to onions, leeks, and chives. It is known for its pungent, strong flavor and aroma. It is used in many different cuisines worldwide, and it is a staple ingredient in many savory dishes. Garlic bulbs consist of several cloves that are wrapped in a paper-like skin."
	},
	{
		"name":"Beetroot",
		"photo_url":"https://snipstock.com/assets/cdn/png/0276d4d518f1a254a4f2dfd6f9b41d00.png",
		"unit":"kg",
		"id":15,
		//"price": 20.99
    "description" : "Beetroot, also known as red beet, is a root vegetable that is part of the Chenopodiaceae family, which also includes spinach, chard, and quinoa. It is typically round or oblong in shape and has a deep red, earthy exterior. Beetroot has a sweet, earthy flavor and a tender, juicy texture."
	},
	{
		"name":"Tomato",
		"photo_url":"https://www.pngpix.com/wp-content/uploads/2016/03/Fresh-Red-Tomato-PNG-image.png",
		"unit":"kg",
		"id":16,
		//"price": 5.99
    "description" : "A tomato is a round, juicy, and fleshy fruit that is part of the nightshade family, which also includes eggplants and bell peppers. It is typically red, but it can also be yellow, orange, or even green depending on the variety. Tomatoes have a slightly sweet, acidic flavor and a smooth, pulpy texture. They are used in many different cuisines around the world, and they are a staple ingredient in many dishes, such as pasta sauces, soups, stews, and salads."
	},
	{
		"name":"Carrot",
		"photo_url":"https://bpb-us-e1.wpmucdn.com/sites.psu.edu/dist/3/29639/files/2015/10/carrot_PNG4985.png",
		"unit":"kg",
		"id":17,
		//"price": 60.99
    "description" : "A carrot is a root vegetable that is known for its orange color and sweet, slightly earthy taste. It is typically long and cylindrical in shape, but it can also be found in other shapes such as short and stubby, or even tapered. Carrots are a good source of Vitamin A, Vitamin K, Vitamin C, and dietary fibers. They also contain other beneficial compounds such as carotenoids and antioxidants."  
	},
	{
		"name":"Onion",
		"photo_url":"https://www.halebankfarmshop.co.uk/wp-content/uploads/2020/08/Red-Onion.jpg",
		"unit":"kg",
		"id":18,
		//"price": 120.99
    "description" : "An onion is a bulbous vegetable that is part of the Allium family, which also includes garlic, leeks, and chives. It is typically round or oblong in shape and has a papery, dry outer layer that covers several layers of flesh. Onions can be white, yellow, or red, with white and yellow being the most common varieties. They have a strong, pungent flavor and aroma. Onions are a staple ingredient in many savory dishes and are used in cooking all around the world."
	},
	{
		"name":"Potato",
		"photo_url":"https://www.photos-public-domain.com/wp-content/uploads/2010/11/potatoes.jpg",
		"unit":"kg",
		"id":19,
		//"price": 80.99
    "description" : "A potato is a starchy, tuberous root vegetable that is part of the nightshade family, which also includes tomatoes and eggplants. It is typically oblong or oval in shape and has a thin, brown, or red-brown skin that covers a white, creamy, or yellow flesh. Potatoes are a staple food in many parts of the world and have been cultivated for thousands of years. They come in many different varieties, such as russet, Yukon gold, red, and fingerling.

"
	}
]
""";

const String nutsList = """
[
  
  {
		"name":"Almond",
		"photo_url":"https://pngimg.com/uploads/almond/almond_PNG17.png",
		"unit":"100g",
		"id":20,
		//"price": 25.99
	},
	{
		"name":"Cashew",
		"photo_url":"https://wallpapercave.com/wp/wp4659333.png",
		"unit":"100g",
		"id":21,
		//"price": 14.99
	},
	{
		"name":"Macadamia",
		"photo_url":"https://i1.wp.com/www.bigislandfarms.com/wp-content/uploads/2018/10/shutterstock_246791536.jpg?fit=5184%2C3456&ssl=1",
		"unit":"100g",
		"id":22,
		//"price": 13.99
	},
	{
		"name":"Pecan",
		"photo_url":"https://cdn3.bigcommerce.com/s-vxy5c/product_images/uploaded_images/roasted-salted-pecan-pieces.jpg?t=1443218694",
		"unit":"100g",
		"id":23,
		//"price": 12.99
	},
	{
		"name":"Pistachio",
		"photo_url":"https://johngoosey.com/wp-content/uploads/pistachios-LASIK-surgery-eyes.jpg",
		"unit":"100g",
		"id":24,
		//"price": 12.99
	}
]
""";

const String spicesList = """
[
  
  {
		"name":"Allspice Ground",
		"photo_url":"https://cdn.shopify.com/s/files/1/0500/3657/2314/products/ALLSPICEPOWDER_grande.jpg?v=1606417169",
		"unit":"100g",
		"id":25,
		//"price": 5.99
	},
	{
		"name":"Black Pepper",
		"photo_url":"https://images.zentail.com/1161/7c852e306a92369b4a4b6cc682fb6b7d4d15f0a16932cd48f1f970d381d0a26c.jpg",
		"unit":"100g",
		"id":26,
		//"price": 4.99
	},
	{
		"name":"Curry",
		"photo_url":"https://www.cakenknife.com/wp-content/uploads/2017/03/Curried-Nut-Mix-Thumbnail-1.jpg",
		"unit":"100g",
		"id":27,
		//"price": 3.99
	},
	{
		"name":"Black Cumin",
		"photo_url":"https://suttons.s3.amazonaws.com/p/VEBLA35253_3.jpg",
		"unit":"100g",
		"id":28,
		//"price": 2.99
	}
]
""";
