def predict_diseases_and_recommendations(data):
    age = data["age"]
    bmi = data["bmi"]
    sugar = data["sugar"]
    sys_bp = data["systolic_bp"]
    dia_bp = data["diastolic_bp"]
    cholesterol = data["cholesterol"]

    diseases = {}

    # Grouped recommendations (doctor-friendly)
    recommendations = {
        "Diet": [],
        "Exercise": [],
        "Monitoring": [],
        "Medical_Advice": []
    }

    # ---------------- Diabetes ----------------
    if sugar < 140:
        diseases["Diabetes"] = "Low"
    elif sugar < 200:
        diseases["Diabetes"] = "Medium"
        recommendations["Diet"].append("Reduce sugar and refined carbohydrates")
    else:
        diseases["Diabetes"] = "High"
        recommendations["Diet"].append("Strict low-sugar diet")
        recommendations["Exercise"].append("Walk 30–45 minutes daily")
        recommendations["Monitoring"].append("Blood sugar check every 3 months")

    # ---------------- Hypertension ----------------
    if sys_bp < 120 and dia_bp < 80:
        diseases["Hypertension"] = "Low"
    elif sys_bp < 140 or dia_bp < 90:
        diseases["Hypertension"] = "Medium"
        recommendations["Diet"].append("Reduce salt intake")
        recommendations["Monitoring"].append("Monitor BP every month")
    else:
        diseases["Hypertension"] = "High"
        recommendations["Diet"].append("Low-sodium diet")
        recommendations["Monitoring"].append("Daily BP monitoring")
        recommendations["Medical_Advice"].append("Consult doctor for BP management")

    # ---------------- Obesity Status (BMI-based) ----------------
    if bmi < 25:
        diseases["Obesity Status (BMI)"] = "Normal"
    elif bmi < 30:
        diseases["Obesity Status (BMI)"] = "Overweight"
        recommendations["Exercise"].append("Increase physical activity")
        recommendations["Diet"].append("Avoid junk and fried foods")
    else:
        diseases["Obesity Status (BMI)"] = "Obese"
        recommendations["Diet"].append("Weight reduction diet")
        recommendations["Exercise"].append("45 minutes walking or exercise daily")
        recommendations["Monitoring"].append("Regular weight monitoring")

    # ---------------- Obesity Risk (Metabolic – No BMI) ----------------
    metabolic_risk_count = 0
    if sugar >= 140:
        metabolic_risk_count += 1
    if sys_bp >= 140 or dia_bp >= 90:
        metabolic_risk_count += 1
    if cholesterol >= 240:
        metabolic_risk_count += 1
    if age >= 45:
        metabolic_risk_count += 1

    if metabolic_risk_count <= 1:
        diseases["Obesity Risk (Metabolic)"] = "Low"
    elif metabolic_risk_count == 2:
        diseases["Obesity Risk (Metabolic)"] = "Medium"
        recommendations["Medical_Advice"].append(
            "Lifestyle modification to prevent metabolic obesity"
        )
    else:
        diseases["Obesity Risk (Metabolic)"] = "High"
        recommendations["Medical_Advice"].extend([
            "Comprehensive lifestyle intervention recommended",
            "Preventive obesity counseling advised"
        ])
        recommendations["Monitoring"].append("Monitor metabolic parameters regularly")

    # ---------------- Heart Disease ----------------
    heart_risk_factors = 0
    if age >= 45:
        heart_risk_factors += 1
    if sys_bp >= 140:
        heart_risk_factors += 1
    if cholesterol >= 240:
        heart_risk_factors += 1

    if heart_risk_factors == 0:
        diseases["Heart Disease"] = "Low"
    elif heart_risk_factors == 1:
        diseases["Heart Disease"] = "Medium"
        recommendations["Monitoring"].append("Annual heart health screening")
    else:
        diseases["Heart Disease"] = "High"
        recommendations["Diet"].append("Heart-friendly diet")
        recommendations["Medical_Advice"].append(
            "ECG and cardiac consultation recommended"
        )

    # Remove empty recommendation categories
    recommendations = {k: v for k, v in recommendations.items() if v}

    return {
        "diseases": diseases,
        "recommendations": recommendations
    }
