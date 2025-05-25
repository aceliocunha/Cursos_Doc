#include <iostream>
#include <vector>
#include <cmath>

double cosineSimilarity(const std::vector<float>& vec1, const std::vector<float>& vec2) {
    float dot_product = 0.0;
    float norm1 = 0.0;
    float norm2 = 0.0;
    for (size_t i = 0; i < vec1.size(); i++) {
        dot_product += vec1[i]*vec2[i];
        norm1 += vec1[i]*vec1[i];
        norm2 += vec2[i]*vec2[i];
    }
    return dot_product / (std::sqrt(norm1)*std::sqrt(norm2));
}

int main() {
    std::vector<float> vec1 = {1.0, 2.0, 3.0, 4.0, 5.0};
    std::vector<float> vec2 = {1.0, 2.0, 3.0, 4.0, 5.0};
    std::cout<<"Cosine Similarity: "<<cosineSimilarity(vec1, vec2)<<std::endl;

    return 0;
}
