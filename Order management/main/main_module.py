from dao.order_processor import OrderProcessor
from Entity.user import User
from Entity.product import Electronics, Clothing

def main():
    order_processor = OrderProcessor()
    
    while True:
        choice = input("Enter your choice: createUser, createProduct, getAllProducts, exit: ")

        if choice == "createUser":
            user_id = int(input("User ID: "))
            username = input("Username: ")
            password = input("Password: ")
            role = input("Role (Admin/User): ")
            user = User(user_id, username, password, role)
            order_processor.create_user(user)
            print("User created successfully.")

        elif choice == "createProduct":
            product_type = input("Product Type (Electronics/Clothing): ")
            product_id = int(input("Product ID: "))
            product_name = input("Product Name: ")
            description = input("Description: ")
            price = float(input("Price: "))
            quantity_in_stock = int(input("Quantity in Stock: "))

            if product_type == "Electronics":
                brand = input("Brand: ")
                warranty_period = int(input("Warranty Period (months): "))
                product = Electronics(product_id, product_name, description, price, quantity_in_stock, brand, warranty_period)
            elif product_type == "Clothing":
                size = input("Size: ")
                color = input("Color: ")
                product = Clothing(product_id, product_name, description, price, quantity_in_stock, size, color)
            else:
                print("Invalid product type.")
                continue

            order_processor.create_product(user, product)
            print("Product created successfully.")

        elif choice == "getAllProducts":
            products = order_processor.get_all_products()
            for product in products:
                print(vars(product))

        elif choice == "exit":
            print("Exiting...")
            break

        else:
            print("Invalid choice. Try again.")

if __name__ == "__main__":
    main()
