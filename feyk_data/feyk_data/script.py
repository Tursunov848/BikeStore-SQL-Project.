##1
import pandas as pd
from faker import Faker
import random
from datetime import datetime

# Fake ma'lumotlar generatori
fake = Faker()

# Nechta yozuv yaratiladi
num_customers = 1000

# Bo'sh ro'yxat
customers_data = []

# Employment status ro'yxati
employment_statuses = ['Employed', 'Unemployed', 'Student', 'Retired', 'Self-Employed']

# Ma'lumotlar yaratish
for i in range(1, num_customers + 1):  # CustomerID: 1 dan 1000 gacha
    full_name = fake.name()
    dob = fake.date_of_birth(minimum_age=18, maximum_age=75)
    email = fake.email()
    phone = fake.phone_number()
    address = fake.address().replace('\n', ', ')
    national_id = fake.unique.random_number(digits=9)
    tax_id = fake.unique.random_number(digits=10)
    employment_status = random.choice(employment_statuses)
    annual_income = round(random.uniform(5000, 150000), 2)
    created_at = fake.date_time_between(start_date='-5y', end_date='-1y')
    updated_at = fake.date_time_between(start_date=created_at, end_date='now')

    customers_data.append({
        "CustomerID": i,
        "FullName": full_name,
        "DOB": dob.strftime('%Y-%m-%d'),
        "Email": email,
        "PhoneNumber": phone,
        "Address": address,
        "NationalID": national_id,
        "TaxID": tax_id,
        "EmploymentStatus": employment_status,
        "AnnualIncome": annual_income,
        "CreatedAt": created_at.strftime('%Y-%m-%d %H:%M:%S'),
        "UpdatedAt": updated_at.strftime('%Y-%m-%d %H:%M:%S')
    })

# DataFrame yaratish
df_customers = pd.DataFrame(customers_data)

# CSV faylga yozish
df_customers.to_csv("customers_fake_data.csv", index=False)

print("✅ 1 dan 1000 gacha bo'lgan 'CustomerID' bilan ma'lumotlar 'customers_fake_data.csv' fayliga saqlandi.")
##2
import pandas as pd
from faker import Faker
import random
from datetime import datetime

# Faylga ulang: Customers fayli kerak bo'ladi
customers_df = pd.read_csv("customers_fake_data.csv")  # FK: CustomerID
customer_ids = customers_df["CustomerID"].tolist()

# Fake generator
fake = Faker()

# BranchIDlar ro'yxati (misol uchun 10 ta filial)
branch_ids = list(range(1, 11))

# Account turi, valyuta, holati
account_types = ['Savings', 'Checking', 'Business', 'Joint']
currencies = ['USD', 'EUR', 'UZS', 'GBP']
status_types = ['Active', 'Inactive', 'Closed']

# Nechta account (bir foydalanuvchida 1-3 ta bo'lishi mumkin)
accounts_data = []
account_id = 1

for customer_id in customer_ids:
    num_accounts = random.randint(1, 3)  # Har bir mijozga 1-3 ta hisob
    for _ in range(num_accounts):
        account_type = random.choice(account_types)
        balance = round(random.uniform(0, 100000), 2)
        currency = random.choice(currencies)
        status = random.choice(status_types)
        branch_id = random.choice(branch_ids)
        created_date = fake.date_between(start_date='-5y', end_date='today')

        accounts_data.append({
            "AccountID": account_id,
            "CustomerID": customer_id,
            "AccountType": account_type,
            "Balance": balance,
            "Currency": currency,
            "Status": status,
            "BranchID": branch_id,
            "CreatedDate": created_date.strftime('%Y-%m-%d')
        })

        account_id += 1

# DataFrame yaratish
df_accounts = pd.DataFrame(accounts_data)

# CSV faylga saqlash
df_accounts.to_csv("accounts_fake_data.csv", index=False)

print(f"✅ {len(df_accounts)} ta Account yozuvlari 'accounts_fake_data.csv' fayliga saqlandi.")
##3
import pandas as pd
from faker import Faker
import random
from datetime import datetime

# Avval account faylidan AccountID larni o'qiymiz (FK uchun)
accounts_df = pd.read_csv("accounts_fake_data.csv")
account_ids = accounts_df["AccountID"].tolist()

# Faker instance
fake = Faker()

# Parametrlar
transaction_types = ['Deposit', 'Withdrawal', 'Transfer', 'Payment']
status_types = ['Completed', 'Pending', 'Failed']
currencies = ['USD', 'EUR', 'UZS', 'GBP']

# Nechta transaction
num_transactions = 5000

transactions_data = []

for txn_id in range(1, num_transactions + 1):
    account_id = random.choice(account_ids)  # FK mos account
    txn_type = random.choice(transaction_types)
    amount = round(random.uniform(10, 10000), 2)
    currency = random.choice(currencies)
    txn_date = fake.date_time_between(start_date='-3y', end_date='now')
    status = random.choice(status_types)
    reference_no = fake.unique.bothify(text='TXN#######')

    transactions_data.append({
        "TransactionID": txn_id,
        "AccountID": account_id,
        "TransactionType": txn_type,
        "Amount": amount,
        "Currency": currency,
        "Date": txn_date.strftime('%Y-%m-%d %H:%M:%S'),
        "Status": status,
        "ReferenceNo": reference_no
    })

# DataFrame yaratish
df_transactions = pd.DataFrame(transactions_data)

# CSV faylga yozish
df_transactions.to_csv("transactions_fake_data.csv", index=False)

print(f"✅ {num_transactions} ta 'Transactions' yozuvi 'transactions_fake_data.csv' fayliga saqlandi.")
##4
import pandas as pd
from faker import Faker

fake = Faker()
num_branches = 20
branches_data = []

for branch_id in range(1, num_branches + 1):
    branch_name = f"{fake.city()} Branch"
    address = fake.address().replace('\n', ', ')
    city = fake.city()
    state = fake.state()
    country = fake.country()
    contact_number = fake.phone_number()
    
    manager_id = None  # To‘g‘rilanishi keyin
    branches_data.append({
        "BranchID": branch_id,
        "BranchName": branch_name,
        "Address": address,
        "City": city,
        "State": state,
        "Country": country,
        "ManagerID": manager_id,
        "ContactNumber": contact_number
    })

df_branches = pd.DataFrame(branches_data)
df_branches.to_csv("branches_fake_data.csv", index=False)

print("✅ 'branches_fake_data.csv' fayli yaratildi.")
##5
import pandas as pd
import random
import os
from faker import Faker

# Fayl nomi
branches_file = "branches_fake_data.csv"
employees_file = "employees_fake_data.csv"

# Faker init
fake = Faker()

# 1️⃣ Branches fayli mavjud bo‘lmasa — uni yaratamiz
if not os.path.exists(branches_file):
    num_branches = 20
    branches_data = []

    for branch_id in range(1, num_branches + 1):
        branch_name = f"{fake.city()} Branch"
        address = fake.address().replace('\n', ', ')
        city = fake.city()
        state = fake.state()
        country = fake.country()
        contact_number = fake.phone_number()
        
        # ManagerID hozircha None
        manager_id = None

        branches_data.append({
            "BranchID": branch_id,
            "BranchName": branch_name,
            "Address": address,
            "City": city,
            "State": state,
            "Country": country,
            "ManagerID": manager_id,
            "ContactNumber": contact_number
        })

    df_branches = pd.DataFrame(branches_data)
    df_branches.to_csv(branches_file, index=False)
    print(f"✅ '{branches_file}' fayli yaratildi.")
else:
    print(f"ℹ️ '{branches_file}' fayli allaqachon mavjud.")
