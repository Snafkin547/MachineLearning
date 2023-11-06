
<div align="right" >
  <img width="200" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/71551321-6500-480f-82fc-3d1e1c0a69e4">
</div>

# HazardousAsteroid_Detection
This project is focused on the classification of near-Earth asteroids into two categories: hazardous and non-hazardous. It involves the analysis of independent attributes like Eccentricity, Diameter, and Orbit Condition to determine if an asteroid can be considered a Potentially Hazardous Asteroid (PHA). A total of 63 different experimental setups have been conducted, utilizing 12 differently processed datasets which include variations in how null values are handled and how the data is sampled. The experiments also vary by the number of features used, ranging from 5 to 7, as well as the method of feature selection. This rigorous testing aims to optimize the classification process and ensure the reliable identification of hazardous asteroids.


### Dataset

The dataset used for the asteroid classification project originates from <a href="https://ssd.jpl.nasa.gov/tools/sbdb_query.html">NASA's Jet Propulsion Laboratory</a> and consists of 22 attributes across 16,616 rows. Prior to analysis, non-contributing features such as the Spacecraft ID (SPK ID), Name, and Near-Earth Object (NEO) status were removed. The data set is unbalanced, containing 1,802 positive examples of potentially hazardous asteroids and 14,184 negative examples. To address this, three different sampling methods were applied to experiment with the data.


### Architecture
<div align="center" >
  <img width="700" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/fd17ef9e-9784-4d1c-8181-cd5ade7b79a0">
</div>

The following pipeline was the best performer in this project
<div align="center" >
  <img width="400" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/5580251e-0160-46d1-84ba-3cb4ea09b31b">
</div>


### Preprocessing & Sampling
Categorical or string data were converted to numeric using one-hot encoding for better processing by machine learning models.
Null values were handled using three different strategies: dropping them, filling them with the attribute mean, or using the mean of the class they belong to.
Four different types of sampling techniques were used to address the imbalance in the dataset:

- No-sampling: Kept the data as is, with 1,217 positive and 9,915 negative instances.
- Over-Sampling: Adjusted the dataset to have a balanced representation by increasing the number of positive samples to 9,915 to match the negatives.
- Under-Sampling: Balanced the dataset by reducing the number of negative samples to 1,217 to match the positives.
- Hybrid-Sampling: Created a balanced dataset with a different approach, resulting in 4,962 balanced samples, inferred to be composed of 4,957 positive and 9,915 negative instances (though there is an apparent inconsistency in the numbers provided for the hybrid-sampling).


### Feature Selection
The image presents different methods used for feature selection in a data analysis project:

- Univariate Feature Selection: This method uses ANOVA test F-values to select features. The five features with the largest F-values chosen here are perihelion distance, observation interval, orbit condition code, absolute magnitude parameter, and Amor (asteroid orbit class).

- Correlation Matrix: Features were selected based on their correlation with the class variable; those with a correlation greater than 0.2 were chosen. The selected features include perihelion distance, observation interval, orbit condition code, absolute magnitude parameter, and asteroid orbit class.

- Wrapper Method: This method involves using a specific machine learning algorithm (Ordinary Least Square in this case) to find optimal features through backward elimination based on p-values less than 5%. The features selected using this method are perihelion distance, observation interval, orbit condition code, absolute magnitude parameter, epoch of osculation, diameter, rotation period, and Amor.

- Principal Component Analysis (PCA): PCA is used to reduce dimensionality by choosing features that explain the maximum amount of variance. Five features are mentioned: perihelion passage, observation interval, epoch of osculation, argument of perihelion, and longitude of ascending node.

- Random Forest: This approach uses the Random Forest (RF) algorithm to select features based on their importance, which is determined by how much they decrease entropy or Gini impurity. The final features selected are mean anomaly, absolute magnitude parameter, perihelion distance, rotation period, and diameter.

Across these methods, common features like perihelion distance and absolute magnitude parameter suggest their significant role in the analysis. Different methods likely serve to confirm the importance of these features or to offer different perspectives on the dataset's structure.


### Classification Algorithm

The classification algorithms used in this project are as follows:

<div align="center" >
  <img width="700" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/b00c9513-b9b5-491c-9535-34bd3f0e8ee2">
</div>


### Evaluation Method

First, a confusion matrix was created from predicted values and actual values.

- CM = confusion_matrix(real_values, pred_values)

Then, we extracted TP, TN, FN, TN from the confusion matrix as follows:

- TN = CM[0][0]
- FN = CM[1][0]
- TP = CM[1][1]
- FP = CM[0][1]

Next, we computed all other required measures as follows:

- Population = TN + FN + TP + FP
- Accuracy = round((TP + TN) / Population, decimal)
- Precision = round(TP / (TP + FP), decimal)
- Recall = round(TP / (TP + FN), decimal)
- Sensitivity = round(TP / (TP + FN), decimal)
- Specificity = round(TN / (TN + FP), decimal)
- F1 = round(2 * ((Precision * Recall) / (Precision + Recall)), decimal)
- FBeta = round((1 + beta2) * (Precision * Recall) / ((beta2 * Precision) + Recall), decimal)
- AUC = roc_auc_score(real_values, pred_values)
- MCC = round(((TP * TN) - (FP * FN)) / sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN)), decimal)

This sample code was created from the Positive class's perspective. 
To measure the Negative class with the same metrics, we flipped TP with TN, and FP with FN in the same confusion matrix and obtained the measurement results in the same format:

- TP = CM[0][0]
- TN = CM[1][1]
- FP = CM[1][0]
- FN = CM[0][1]

Finally, we averaged each of these measures from two computations for the weighted average. The following section will present the results of all models in this configuration.


### Results Summary
The Random Forest model achieved a high accuracy of 99%. The model had 5 layers and used feature selection to identify the top 5 attributes.
Data preprocessing included filling missing values with the class-wise average. The original dataset was used without any sampling technique applied.
The confusion matrix for the Asteroid Dataset indicates a strong predictive performance with the majority of predictions concentrated in the true positive and true negative areas.
The ROC curve illustrates an excellent true positive rate across all thresholds, which suggests a good balance between sensitivity and specificity.

<div align="center">
<table>

  <tr>
    <td>
      <img width="376" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/e45316eb-ac6c-4c78-9525-c69108fb9b31">
    </td>
    <td>
      <img width="401" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/235ab5ee-e78b-41bc-a003-56068a0fb0a3">
    </td>
  </tr>

</table>
</div>


### Takeaway and Further Research

The slide outlines the conclusions and considerations for further research following a data analysis project:

- The best-performing model achieved 99% accuracy and 98% average F1 score, which are metrics used to evaluate the precision and robustness of a predictive model.

However, it was observed that not all models benefited from the training dataset in its original form. Specifically:

- The average F1 score for the hazardous class across all 25 models was only 73%.
- A neural network (NN) using Univariate Feature Selection (FS) achieved just 48% F1 score, but this improved to 70% when hybrid-sampling was applied.

The most effective model used Random Forest for feature selection and identified Rotation Period and Diameter as significant features.

There are concerns regarding the data handling process, particularly:
- Manipulation through null handling, where 93% and 89% accuracy was achieved by filling missing values with class-wise averages.
- It's unclear whether preprocessing contributed to the strong performance of the model.
- There is a question about the generalizability of the model, especially considering whether a model trained on a limited dataset (after null values were dropped) would be effective in identifying real-world hazardous asteroids.

The takeaway suggests that while the model performs well on the current dataset, the methodologies and data handling strategies might affect the model's ability to generalize to new data, pointing to areas where further research and validation are necessary.
