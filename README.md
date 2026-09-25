# 🍽️ Food Rescue & Redistribution Spatial Database

## 📌 Project Overview
The **Food Rescue & Redistribution Spatial Database** is a GIS-based system designed to manage surplus food donors, NGOs, volunteers, and food donations using spatial data.  

It leverages **PostgreSQL with PostGIS** for spatial storage and queries, and **ArcGIS/ArcMap** for geographic visualization.

---

## 🎯 Objectives
- Store donor, NGO, and volunteer locations  
- Manage food donations  
- Calculate distances between locations  
- Find the nearest NGO or volunteer  
- Search NGOs/volunteers within a specific radius  
- Visualize entities on ArcMap  

---

## 🛠️ Technologies Used
- **PostgreSQL**  
- **PostGIS**  
- **psql**  
- **ArcGIS ArcMap**  
- **SQL**  

---
## 🗂️ Project Structure

Food-Rescue-Spatial-DB/
│
├── database/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── spatial_queries.sql
│
├── arcgis/
│   └── Food_Rescue_Map.mxd
│
└── README.md














































---

## 👥 Demo Data
- **Admin**: 1  
- **Donors**: 4  
- **NGOs**: 6  
- **Volunteers**: 10  

---

## 🗺️ Spatial Data
Entities with geographic locations:
- Donors  
- NGOs  
- Volunteers  
- Admin  

Locations are stored as **PostGIS geometry points** with **SRID 4326**.

---

## 📍 Spatial Operations
The database supports:
1. Distance calculation  
2. Nearest NGO search  
3. Nearest volunteer search  
4. NGOs within 5 km  
5. Volunteers within 5 km  
6. Nearest NGO for every donor  

---

## 🗺️ ArcGIS Integration
- PostgreSQL/PostGIS is connected to **ArcMap**.  
- ArcMap displays donors, NGOs, volunteers, and admin on a geographic basemap.  

---
