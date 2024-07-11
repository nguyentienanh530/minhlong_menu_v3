import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/common/widget/grid_item_food.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/view/screen/food_screen.dart';

import '../../../food/data/model/food_model.dart';
import '../../data/model/category_model.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final CategoryModel categoryModel = CategoryModel(
    id: 0,
    name: 'Cơm',
    image:
        'https://lh3.googleusercontent.com/fife/ALs6j_EJJORcT5PPDqWnznPyiQ2cHGH2qK2-CJyqRq4uLik7P9sToh0r2yILfDr9QUYMxMy9mjv3bgP7MtzvfoLowiepddJhmdnIh1CWA6puqMXa6x0M_yXspOdbgogncVTlK4dnQhhkBjksU-vmOnx0gR2uly9ilUUzI-zPGc8QC52jxBCvCkUU1cJ4OqXRQqvG1aGxktKKntgE5KRdFzWA6vdlTuAO9bKUlYYNOq20C49WGbDgxqE6fVMkQwtUGE9kBHj3iSunlhrg8gjYsR-3ZVXf_fIbFG2BU0MqvHcUUIyC42SKA3026iCyybIRjF7DeZmAZF7IC3lMXzEnw6jkdu12m_2ayxUGIJDRpjDobqIPIZZUrmiVUE0TJ0Gr-73yL2I5gAxmzkoU5sa-AuYLlnqXn9IrxYqOrbF_bbaB2OC8FnlqcjkS8Cv5yNhafopK1Jpl7DZiXxn__0ktOFvBVRT1Edkkn0MhjwBDmShAQEq1Ixu18BaB_0hoCQFpRmeiTNE6H-VmbH69D-4EdCeJPXyk1sQlF7lsBAnr-TlNGzek6G_2qkcftvyYHT5axaDXTPBCMwjfdAJidjTZfYC-4bluQN2VeB6_jiWODe7c4kJYviQV3IxrTf5ND3nhW05klINlejEJXTJPK_ihKLC72HbcrX2HxvoOAnpJ6IXHusbY6v5ATpCM3aAXVy2rImWkwmwnZnbQL05AK9tsPPXXX3Sx3bk6NbAw3gQDn3FyNAvFtDMiQ7K28mvEZMCYWmwmwE-LTWY2gHTq4vEzBLU7IaYMmy_nkW2U2K5oeAfkdz5WAWLij76HRIYuGIy410eUHK4qly-LPUgIncDi2RPXpft67_okxMfFYtgitozpuNOQs1aUxIKUKn5ajEjFlbrLunevF8cQudUlivbBExc8TpP5Dh4rHiRER1dZWBgfFQZkjD_EyWG3CW-UzjPglvLifptYEAiASF45M96ffovzGcQ1D0kUO1cDH3RKlylRp9R69GFZXVhhDYgE4FHwaUuKauC8XD8RZvEZsstU98WHHQ9BxZTLIQMgAZ9oP9pN2OC8Q4Tm94YOfE6U6wjbl861G4_bcWxyybQEPbF572dcbVddvUwi0d5u_F2jLKaYyJlN7iVwKkgMKZOQTjjyu4SjAevtZupZ0A9MSqtDc1eDtycKEUMvcNngw-_yIq4o6hm9-s8TY2f5JmNFyViMrv-U3q6IOV6kCYSkvWTP-XqSU1M1405XAoMv7xjd3fTxX29ZdHUPeRaW2R9CYg6k0qlQ1U2JmnmFuOQXy9O5AJ8oZf9UPG7zhN2GFBh6x9nH1pCNqX8twQV56Onk1e5A-wBXzj0Sb3k1ZNaN5sQHZEGDDJz09uDBB1kuDEqXDcAZgbk9aIomvmeCLOM3jgk3Ec-o1XgUOCbpV08foRG6xNF8ygp0X8YQKwdE5bFon1RD4suPmBMTJrsoj38I5fOnySJVNVjmzOqzOT7TWi8fmzA8j0agvWrSWBa0x8nugrSHkasw9KRrt-HBhNDqqbFs5VJc9ckerwnlw7-xj50D1xtktZOqc9JCKzhkR0fOxXEyOFEGIL_sD1SoS51A79of9biDpP6BkLNBryS1KcCLpncNYYWuDVvu78p5F-XwbonSI2tN10HSBgNpIRki=w884-h702',
    serial: 1,
  );
  final FoodModel foodModel = FoodModel(
    id: 1,
    name: 'Bánh mì',
    categoryID: 1,
    isShow: true,
    isDiscount: true,
    discount: 10,
    price: 200000,
    photoGallery: [
      'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
      'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
      'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
    ],
    description: '123123',
    orderCount: 10,
    createAt: '2021-11-11 11:11:11',
  );
  final List<FoodModel> listFood = List.generate(
      10,
      (index) => FoodModel(
            id: 1,
            name: 'Bánh mì',
            categoryID: 1,
            isShow: true,
            isDiscount: true,
            discount: 10,
            price: 200000,
            photoGallery: [
              'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
              'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
              'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
            ],
            description: '123123',
            orderCount: 10,
            createAt: '2021-11-11 11:11:11',
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          stretch: true,
          backgroundColor: AppColors.transparent,
          expandedHeight: context.isPortrait
              ? 0.4 * context.sizeDevice.height
              : 0.4 * context.sizeDevice.width,
          flexibleSpace: FlexibleSpaceBar(background: _buildHead(context)),
        ),
        SliverToBoxAdapter(child: _buildBody()),
      ],
    ));
  }

  Widget _buildHead(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                child: FittedBox(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      width: context.sizeDevice.width * 0.6,
                      margin: const EdgeInsets.only(top: defaultMargin * 4),
                      child: CachedNetworkImage(imageUrl: categoryModel.image)),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            top: context.isPortrait
                ? context.sizeDevice.height * 0.2
                : context.sizeDevice.width * 0.2,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900),
                ),
                Text(
                  categoryModel.name,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColors.themeColor,
                      height: 1),
                ),
                Text(
                  '80 Món',
                  style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
                ),
              ],
            ))
      ],
    );
  }

  Widget _buildBody() {
    return GridItemFood(
      list: listFood,
      modeScreen: ModeScreen.foodsOnCategory,
      crossCount: 1,
      aspectRatio: 9 / 5.7,
    );
  }
}
