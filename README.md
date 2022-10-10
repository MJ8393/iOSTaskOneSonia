# 1SONIAiOSTask
Task for iOS developer from 1Sonia

Developer: Mekhriddin Jumaev
Company: 1 sonia

Architechture: MVVM
Programatic UI with Snapkit
Used Kingfisher to download pictures
Used TableView to present Data
Network Manager for netwroking requests
Persistance Manager for saving data to database (used CoreData)

Description: 
App multi qahramonlar haqidagi datani qabul qiladi va uni UI da ko'rsatadi. Pagination ishlatilingan. Har bitta pageda 20 ta element. Qabul qilib olingan elementlar CoreData ga saqlanadi va qayta run qilinganda request jo'natilmaydi, CoreData dan o'qiladi. Core dataga saqlanmagan elementlar uchun yana request jo'natiladi. O'chirish tugmasi orqali CoreData dagi barcha characterlar o'chirib tashlanadi va page = 1 bilan request jo'natilib boshlang'ich bosqichga qaytariladi.
