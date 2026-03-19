// PART 2.2 — MongoDB Operations:-
// use sample_documents;

// OP1: insertMany() — insert all 3 documents from sample_documents.json .
db.products.insertMany([
  {
    category: "Electronics",
    product_name: "Smartphone X",
    brand: "TechBrand",
    price: 25000,
    warranty_years: 1,
    specs: {
      ram: "8GB",
      storage: "128GB",
      battery: "5000mAh"
    }
  },
  {
    category: "Groceries",
    product_name: "Organic Milk",
    brand: "FarmFresh",
    price: 60,
    expiry_date: new Date("2024-12-15"),
    weight: "1L",
    ingredients: ["Milk"],
    is_organic: true
  },
  {
    category: "Clothing",
    product_name: "Men T-Shirt",
    brand: "FashionHub",
    price: 799,
    material: "Cotton",
    color: "Black",
    available_sizes: ["S", "M", "L", "XL"]
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000 .
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01 .
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product.
db.products.updateOne(
  { product_name: "Smartphone X" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why.
db.products.createIndex({ category: 1 });

// Explanation:
//Index improves query performance when filtering by category.
