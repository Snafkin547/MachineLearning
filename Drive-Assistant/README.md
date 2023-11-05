# Drive Assistant

Drive Assistant (DA) is a Python-based deep learning model that classifies road images into two categories: those with potholes and those without. 
It employs a derivative of GoogLeNet and has achieved an accuracy rate of 88.46% in the successful detection of potholes in road images, all while avoiding overfitting.

<div align="center">
<table width="100%">
  <tr>
    <td align = "center" width="(100/x)%">
          <img width="965" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/e5c5feed-a014-42e4-853c-7022e11c2c2b">
    </td>
    <td align = "center" width="(100/x)%">
          <img width="969" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/f546904a-e57f-487e-82c7-4f07e3002230">
    </td>
    <td align = "center" width="(100/x)%">
         <img width="974" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/fd4fee8b-7764-459f-872b-1dbea3d9d845">
    </td>
    <td align = "center" width="(100/x)%">
          <img width="977" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/cb323ee5-f71d-498a-8ff5-389111d29ac4">
    </td>
    <td align = "center" width="(100/x)%">
          <img width="977" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/a1f974c8-8d92-4867-85fe-021c534a0bb3">
    </td>
    <td align = "center" width="(100/x)%">
         <img width="981" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/aa578f42-7a77-4ffe-85a9-a7333493bb81">
    </td>
 </tr>
  <tr>
    <td align = "center" width="(100/x)%">
          <img width="968" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/7d019533-a690-40f1-99d4-8c907f9a5002">
    </td>
    <td align = "center" width="(100/x)%">
         <img width="974" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/cdaee7a4-3f67-4a70-848f-4282d774c285">
    </td>
    <td align = "center" width="(100/x)%">
         <img width="986" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/6b092351-f8cf-46cd-a222-3ef5986a1d06">
    </td>
    <td align = "center" width="(100/x)%">
          <img width="958" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/608d6635-63a0-40e9-bb3e-eaea1a0853ef">
    </td>
    <td align = "center" width="(100/x)%">
          <img width="975" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/0f479d63-8598-41e9-9b64-b1e69e1be84d">
    </td>
    <td align = "center" width="(100/x)%">
         <img width="978" alt="image" src="https://github.com/Snafkin547/MachineLearning/assets/62607343/db9b4e5b-2fc0-434a-bbfb-65c60c2100de">
    </td>
 </tr>
 
</table>
</div>

### Architecture
The big picture of the Drive Assistant’s (DA) architecture consists of the following components: Data Import from Kaggle, Pre-processing, a Convolutional Neural Network (CNN), and signal processing for Drive Instruction.

The core of DA is structured around the GoogLeNet architecture, which includes convolutional layers, max-pooling layers, inception layers (a combination of convolutional layers and a max-pooling layer), a global average pooling layer instead of a flattening layer, and a sigmoid function in the output layer.

To improve accuracy, I implemented several modifications to the original architecture:

First, I used SELU as the activation function instead of ReLU and Leaky-ReLU to prevent potential gradient saturation and the dying ReLU problem. SELU was specifically applied to the inception layers. Additionally, I increased the number of feature map outputs in the first two layers from 64 to 150. I also added three fully connected layers (with 1000, 100, and 100 neurons, respectively) before the output layer.

These modifications, however, increased the risk of overfitting. In fact, the model did experience slight overfitting when the number of feature maps was increased to 175 and 200, which led to a decrease in accuracy to 82.10% (a reduction of 4.10%) and 80.64% (a reduction of 5.56%), respectively. Similarly, adding four fully connected layers (with 1000, 1000, 100, and 100 neurons) resulted in a reduced accuracy of 83.02% (a decrease of 3.18%). Consequently, the current model retains 150 feature maps in the first two layers and includes three fully connected layers, as illustrated in the following diagram.

<img alt="image" src="https://user-images.githubusercontent.com/62607343/130650910-62b161bc-af75-4f02-b446-e8f50ef4f797.png">


### Data Ingestion

DA accepts any size of road images without error and standardize it to (276, 368) size.
The following screenshots show the snippets of the data injection pipeline.

<div align="center">
<table width="100%">
  <tr>
    <td align = "center" width="(100/x)%">
          <img width="900" alt="image" src="https://user-images.githubusercontent.com/62607343/130651177-c25b47e1-7bdd-4d8a-a5eb-c7a3d6507b2f.png">
    </td>
    <td align = "center" width="(100/x)%">
          <img width="400" alt="image" src="https://user-images.githubusercontent.com/62607343/130651465-9412e38f-a542-48f5-952a-37a3032c04ab.png">
    </td>
 </tr>
</table>
</div>


### Data Augmentation

DA incorporates data augmentation into its pipeline, which involves rescaling RGB values to the 0.0–1.0 range, randomly rotating images by up to 50 degrees, and shifting them vertically and horizontally by a maximum of 20%.

### Use of HDF5 Format

 By utilizing the HDF5 file format, the model accelerates its learning speed.

### Activation & Initialization


ReLU addresses the gradient saturation problem inherent in the Sigmoid and Tanh functions. ReLU's output remains active for positive input values, although it becomes inactive (zero output) for negative inputs. Leaky-ReLU is an enhanced version of ReLU that allows for a small, non-zero gradient when the input is negative, which prevents neurons from dying out. In the case of Drive Assistant (DA), switching to Leaky-ReLU resulted in a 4.51% increase in accuracy compared to using ReLU.

This week, I also introduced SELU to DA. Unlike ReLU and Leaky-ReLU, SELU maintains a non-zero gradient even when the input is zero, thus fully addressing the dying ReLU problem. While the substitution to SELU alone did not enhance accuracy beyond what was achieved with Leaky-ReLU, the combination of SELU, L1 regularization, and a decaying learning rate of 0.95% yielded the best performance at 88.46%. Below is a summary table of the activation functions and initializers relevant to my project.

<div align="center" >
<img height="400" width="auto" src="https://user-images.githubusercontent.com/62607343/130621436-9b2ae0da-3ef5-4657-a67c-5fd116c9475d.png">
</div>

### Regularizer

<u>L1 class (Lasso Regression)<u/>
   tf.keras.regularizers.l1(l1=0.01, **kwargs)
   The L1 regularization penalty is computed as: loss = l1 * reduce_sum(abs(x))
 
<u>L2 class (Ridge Regression)<u/>
   tf.keras.regularizers.l2(l2=0.01, **kwargs)
   The L2 regularization penalty is computed as: loss = l2 * reduce_sum(square(x))

<u>L1_L2 function<u/>
   tf.keras.regularizers.l1_l2(l1=0.01, l2=0.01)
   The L1 regularization penalty is computed as: loss = l1 * reduce_sum(abs(x))
   The L2 regularization penalty is computed as: loss = l2 * reduce_sum(square(x))


### Drive Signal

DA signals “Keep going” if there is no pothole and “Stop” if there is any pothole as the following screenshot:

<div align="center">
<table width="100%">
  <tr>
    <td align = "center" width="(100/x)%">
          <img width="300" src=https://user-images.githubusercontent.com/62607343/130651041-e3a2b913-c86d-4f97-a6aa-d5ff06b53117.png>
    </td>
    <td align = "center" width="(100/x)%">
          <img width="300" src=https://user-images.githubusercontent.com/62607343/130651080-cd5ef267-4613-499a-b891-51d853d32246.png>
    </td>
 </tr>
</table>
</div>


### Result 

The GoogLeNet derivative developed for this project has achieved an accuracy rate of 88.46% in successfully detecting potholes in road images.

<img width="800" alt="image" src="https://user-images.githubusercontent.com/62607343/130652346-2ae4c0af-28a2-4010-8713-5ff9ce711dd1.png">
