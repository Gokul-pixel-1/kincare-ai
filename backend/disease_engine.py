# ---------- State to Region Mapping (India) ----------
def get_region_from_state(state):
    south = ["Tamil Nadu", "Kerala", "Karnataka", "Andhra Pradesh", "Telangana"]
    north = ["Delhi", "Punjab", "Haryana", "Uttar Pradesh", "Uttarakhand", "Himachal Pradesh"]
    west = ["Maharashtra", "Gujarat", "Rajasthan", "Goa"]
    east = ["West Bengal", "Odisha", "Bihar", "Jharkhand"]
    northeast = ["Assam", "Arunachal Pradesh", "Manipur", "Mizoram",
                 "Nagaland", "Tripura", "Meghalaya", "Sikkim"]
    central = ["Madhya Pradesh", "Chhattisgarh"]

    if state in south:
        return "South"
    elif state in north:
        return "North"
    elif state in west:
        return "West"
    elif state in east:
        return "East"
    elif state in northeast:
        return "NorthEast"
    elif state in central:
        return "Central"
    else:
        return "Generic"


# ---------- Region-based Diet Plans ----------
def get_regional_diet(disease, region):
    diets = {
        "South": {
            "Diabetes": [
                "Prefer idli or dosa with less oil",
                "Use millets instead of white rice",
                "Avoid sweets and sugary drinks"
            ],
            "Hypertension": [
                "Reduce salt in sambar and rasam",
                "Avoid pickles and papads"
            ],
            "Obesity": [
                "Avoid fried snacks like vada and bajji",
                "Prefer steamed foods"
            ],
            "Heart Disease": [
                "Limit oil usage",
                "Avoid deep-fried foods"
            ]
        },

        "North": {
            "Diabetes": [
                "Limit roti quantity",
                "Avoid sweets and sugar drinks"
            ],
            "Hypertension": [
                "Reduce salt and butter usage",
                "Avoid pickles"
            ],
            "Obesity": [
                "Avoid fried snacks",
                "Control portion size"
            ],
            "Heart Disease": [
                "Avoid ghee-heavy foods",
                "Prefer vegetables and fruits"
            ]
        },

        "West": {
            "Diabetes": [
                "Limit sugary snacks",
                "Control portion size"
            ],
            "Hypertension": [
                "Reduce salt intake",
                "Avoid processed foods"
            ],
            "Obesity": [
                "Avoid fried snacks",
                "Prefer home-cooked food"
            ],
            "Heart Disease": [
                "Limit oil and salt",
                "Include fruits"
            ]
        },

        "East": {
            "Diabetes": [
                "Reduce white rice intake",
                "Avoid sweets"
            ],
            "Hypertension": [
                "Reduce salt",
                "Avoid fried foods"
            ],
            "Obesity": [
                "Control rice portion",
                "Avoid fried snacks"
            ],
            "Heart Disease": [
                "Avoid oily foods",
                "Increase vegetables"
            ]
        },

        "NorthEast": {
            "Diabetes": [
                "Avoid sugary foods",
                "Include vegetables and fruits"
            ],
            "Hypertension": [
                "Reduce salt",
                "Avoid smoked foods"
            ],
            "Obesity": [
                "Control portions",
                "Regular physical activity"
            ],
            "Heart Disease": [
                "Avoid fatty meats",
                "Include fruits"
            ]
        },

        "Central": {
            "Diabetes": [
                "Limit rice and sweets",
                "Include vegetables"
            ],
            "Hypertension": [
                "Reduce salt",
                "Avoid fried snacks"
            ],
            "Obesity": [
                "Avoid oily foods",
                "Control portion size"
            ],
            "Heart Disease": [
                "Avoid ghee-heavy foods",
                "Prefer vegetables"
            ]
        }
    }

    return diets.get(region, {}).get(disease, [])


# ---------- Main Prediction Function ----------
def predict_diseases_and_recommendations(data):
    age = data["age"]
    bmi = data["bmi"]
    sugar = data["sugar"]
    sys_bp = data["systolic_bp"]
    dia_bp = data["diastolic_bp"]
    cholesterol = data["cholesterol"]

    # OPTIONAL input (backward compatible)
    state = data.get("state", "Tamil Nadu")
    region = get_region_from_state(state)

    diseases = {}

    recommendations = {
        "Diet": [],
        "Exercise": [],
        "Monitoring": [],
        "Medical_Advice": []
    }

    # -------- Diabetes --------
    if sugar < 140:
        diseases["Diabetes"] = "Low"
    elif sugar < 200:
        diseases["Diabetes"] = "Medium"
        recommendations["Diet"].extend(get_regional_diet("Diabetes", region))
    else:
        diseases["Diabetes"] = "High"
        recommendations["Diet"].extend(get_regional_diet("Diabetes", region))
        recommendations["Exercise"].append("Walk 30–45 minutes daily")
        recommendations["Monitoring"].append("Blood sugar check every 3 months")

    # -------- Hypertension --------
    if sys_bp < 120 and dia_bp < 80:
        diseases["Hypertension"] = "Low"
    elif sys_bp < 140 or dia_bp < 90:
        diseases["Hypertension"] = "Medium"
        recommendations["Diet"].extend(get_regional_diet("Hypertension", region))
        recommendations["Monitoring"].append("Monitor BP every month")
    else:
        diseases["Hypertension"] = "High"
        recommendations["Diet"].extend(get_regional_diet("Hypertension", region))
        recommendations["Monitoring"].append("Daily BP monitoring")
        recommendations["Medical_Advice"].append("Consult doctor for BP management")

    # -------- Obesity Status (BMI) --------
    if bmi < 25:
        diseases["Obesity Status (BMI)"] = "Normal"
    elif bmi < 30:
        diseases["Obesity Status (BMI)"] = "Overweight"
        recommendations["Diet"].extend(get_regional_diet("Obesity", region))
        recommendations["Exercise"].append("Increase physical activity")
    else:
        diseases["Obesity Status (BMI)"] = "Obese"
        recommendations["Diet"].extend(get_regional_diet("Obesity", region))
        recommendations["Exercise"].append("45 minutes walking or exercise daily")
        recommendations["Monitoring"].append("Regular weight monitoring")

    # -------- Obesity Risk (Metabolic) --------
    metabolic_risk = 0
    if sugar >= 140:
        metabolic_risk += 1
    if sys_bp >= 140 or dia_bp >= 90:
        metabolic_risk += 1
    if cholesterol >= 240:
        metabolic_risk += 1
    if age >= 45:
        metabolic_risk += 1

    if metabolic_risk <= 1:
        diseases["Obesity Risk (Metabolic)"] = "Low"
    elif metabolic_risk == 2:
        diseases["Obesity Risk (Metabolic)"] = "Medium"
        recommendations["Medical_Advice"].append(
            "Lifestyle modification to prevent metabolic obesity"
        )
    else:
        diseases["Obesity Risk (Metabolic)"] = "High"
        recommendations["Medical_Advice"].append(
            "Comprehensive lifestyle intervention recommended"
        )
        recommendations["Monitoring"].append("Monitor metabolic parameters regularly")

    # -------- Heart Disease --------
    heart_risk = 0
    if age >= 45:
        heart_risk += 1
    if sys_bp >= 140:
        heart_risk += 1
    if cholesterol >= 240:
        heart_risk += 1

    if heart_risk == 0:
        diseases["Heart Disease"] = "Low"
    elif heart_risk == 1:
        diseases["Heart Disease"] = "Medium"
        recommendations["Monitoring"].append("Annual heart health screening")
    else:
        diseases["Heart Disease"] = "High"
        recommendations["Diet"].extend(get_regional_diet("Heart Disease", region))
        recommendations["Medical_Advice"].append(
            "ECG and cardiac consultation recommended"
        )

    # Remove empty categories
    recommendations = {k: v for k, v in recommendations.items() if v}

    return {
        "diseases": diseases,
        "recommendations": recommendations
    }
