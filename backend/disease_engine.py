def predict_diseases_and_recommendations(data):

    # ---------- SAFE INPUT READING ----------
    try:
        age = float(data["age"])
        bmi = float(data["bmi"])
        sugar = float(data["sugar"])
        sys_bp = float(data["systolic_bp"])
        dia_bp = float(data["diastolic_bp"])
        cholesterol = float(data["cholesterol"])
    except:
        return {
            "status": "error",
            "message": "Invalid or missing input values. Please check input format."
        }

    # ---------- FAMILY HISTORY INPUT ----------
    fh_diabetes = data.get("family_history_diabetes", "none")
    fh_heart = data.get("family_history_heart", "none")
    fh_bp = data.get("family_history_bp", "none")
    fh_obesity = data.get("family_history_obesity", "none")

    # ---------- VALIDATION ----------
    errors = []
    if age <= 0: errors.append("Age must be positive")
    if bmi <= 0: errors.append("BMI must be positive")
    if sugar <= 0: errors.append("Blood sugar must be positive")
    if sys_bp <= 0 or dia_bp <= 0: errors.append("Blood pressure must be positive")
    if cholesterol <= 0: errors.append("Cholesterol must be positive")

    if errors:
        return {"status": "error", "errors": errors}


    diseases = {}
    reasons = {}
    risk_scores = {}

    recommendations = {
        "Diet": [],
        "Exercise": [],
        "Monitoring": [],
        "Medical_Advice": []
    }


    # ============================================================
    # ----------------------- DIABETES ---------------------------
    # ============================================================
    diabetes_score = 0
    diabetes_reasons = []

    if sugar < 140:
        diabetes_score += 10
    elif sugar < 200:
        diabetes_score += 60
        diabetes_reasons.append("Blood sugar above normal range")
        recommendations["Diet"].append("Reduce sugar and refined carbohydrates")
    else:
        diabetes_score += 90
        diabetes_reasons.append("High blood sugar indicates diabetes risk")
        recommendations["Diet"].append("Strict low-sugar diet")
        recommendations["Exercise"].append("Walk 30–45 minutes daily")
        recommendations["Monitoring"].append("Blood sugar check every 3 months")

    if bmi >= 30:
        diabetes_score += 10
        diabetes_reasons.append("High BMI increases diabetes risk")

    # -------- FAMILY HISTORY BOOST --------
    if fh_diabetes == "one_parent":
        diabetes_score += 20
        diabetes_reasons.append("Family history increases diabetes risk")
    elif fh_diabetes == "both_parents":
        diabetes_score += 35
        diabetes_reasons.append("Strong genetic diabetes risk")
    elif fh_diabetes == "sibling":
        diabetes_score += 25
        diabetes_reasons.append("Sibling with diabetes increases risk")

    diabetes_score = min(diabetes_score, 100)
    risk_scores["Diabetes"] = diabetes_score

    if diabetes_score < 30:
        diseases["Diabetes"] = "Low"
    elif diabetes_score < 70:
        diseases["Diabetes"] = "Medium"
    else:
        diseases["Diabetes"] = "High"

    reasons["Diabetes"] = diabetes_reasons


    # ============================================================
    # --------------------- HYPERTENSION -------------------------
    # ============================================================
    bp_score = 0
    bp_reasons = []

    if sys_bp >= 140 or dia_bp >= 90:
        bp_score += 85
        bp_reasons.append("Blood pressure is in hypertension range")
        recommendations["Diet"].append("Low-sodium diet")
        recommendations["Monitoring"].append("Daily BP monitoring")
        recommendations["Medical_Advice"].append("Consult doctor for BP management")
    elif sys_bp >= 120 or dia_bp >= 80:
        bp_score += 50
        bp_reasons.append("Blood pressure trending high")
        recommendations["Monitoring"].append("Monitor BP every month")
    else:
        bp_score += 10

    # -------- FAMILY HISTORY BOOST --------
    if fh_bp == "one_parent":
        bp_score += 15
        bp_reasons.append("Family history increases BP risk")
    elif fh_bp == "both_parents":
        bp_score += 25
        bp_reasons.append("Strong family history of BP")

    bp_score = min(bp_score, 100)
    risk_scores["Hypertension"] = bp_score

    if bp_score < 30:
        diseases["Hypertension"] = "Low"
    elif bp_score < 70:
        diseases["Hypertension"] = "Medium"
    else:
        diseases["Hypertension"] = "High"

    reasons["Hypertension"] = bp_reasons


    # ============================================================
    # ----------------------- OBESITY (BMI) ----------------------
    # ============================================================
    obesity_score = 0
    obesity_reasons = []

    if bmi < 25:
        obesity_score += 10
        diseases["Obesity Status (BMI)"] = "Normal"
    elif bmi < 30:
        obesity_score += 60
        diseases["Obesity Status (BMI)"] = "Overweight"
        obesity_reasons.append("BMI in overweight range")
        recommendations["Exercise"].append("Increase physical activity")
        recommendations["Diet"].append("Avoid junk and fried foods")
    else:
        obesity_score += 95
        diseases["Obesity Status (BMI)"] = "Obese"
        obesity_reasons.append("BMI in obese range")
        recommendations["Diet"].append("Weight reduction diet")
        recommendations["Exercise"].append("45 minutes walking or exercise daily")
        recommendations["Monitoring"].append("Regular weight monitoring")

    # -------- FAMILY HISTORY BOOST --------
    if fh_obesity == "one_parent":
        obesity_score += 10
        obesity_reasons.append("Family history increases obesity risk")
    elif fh_obesity == "both_parents":
        obesity_score += 20
        obesity_reasons.append("Strong family history of obesity")

    obesity_score = min(obesity_score, 100)
    risk_scores["Obesity"] = obesity_score
    reasons["Obesity"] = obesity_reasons


    # ============================================================
    # ---------------- HEART DISEASE RISK ------------------------
    # ============================================================
    heart_score = 0
    heart_reasons = []

    if age >= 45:
        heart_score += 20
        heart_reasons.append("Age ≥ 45 increases heart risk")

    if sys_bp >= 140:
        heart_score += 30
        heart_reasons.append("High blood pressure")

    if cholesterol >= 240:
        heart_score += 40
        heart_reasons.append("High cholesterol level")

    if bmi >= 30:
        heart_score += 10
        heart_reasons.append("Obesity increases heart risk")

    # -------- FAMILY HISTORY BOOST --------
    if fh_heart == "one_parent":
        heart_score += 20
        heart_reasons.append("Family history increases heart disease risk")
    elif fh_heart == "both_parents":
        heart_score += 30
        heart_reasons.append("Strong family history of heart disease")
    elif fh_heart == "early_attack":
        heart_score += 40
        heart_reasons.append("Early heart attack in family — very high risk")
    elif fh_heart == "sibling":
        heart_score += 25
        heart_reasons.append("Sibling with heart disease — risk increases")

    heart_score = min(100, heart_score)
    risk_scores["Heart Disease"] = heart_score

    if heart_score < 30:
        diseases["Heart Disease"] = "Low"
    elif heart_score < 70:
        diseases["Heart Disease"] = "Medium"
    else:
        diseases["Heart Disease"] = "High"
        recommendations["Medical_Advice"].append("ECG and cardiac consultation recommended")
        recommendations["Diet"].append("Heart-friendly diet")


    # ============================================================
    # -------- REMOVE EMPTY RECOMMENDATION GROUPS ---------------
    # ============================================================
    recommendations = {k: v for k, v in recommendations.items() if v}


    return {
        "status": "success",
        "risk_scores": risk_scores,
        "diseases": diseases,
        "reasons": reasons,
        "recommendations": recommendations
    }

