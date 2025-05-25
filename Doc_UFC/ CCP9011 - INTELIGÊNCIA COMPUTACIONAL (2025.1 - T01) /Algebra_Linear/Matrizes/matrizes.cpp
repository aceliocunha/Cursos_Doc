#include <torch/torch.h>
#include <iostream>

int main() {
    const torch::Tensor A = at::randn({2, 3});
    const torch::Tensor B = at::randn({3, 2});
    std::cout << "Tensor A:\n" << A << std::endl;
    std::cout <<"Tensor B:\n" << B << std::endl;
    // arithmetic
    const torch::Tensor V = at::pow(A ,4.0);
    std::cout << "element wise V = A * 4 :\n";
    print(V);
    // matrix operations
    const torch::Tensor D = at::matmul(A, B);
    std::cout <<"Tensor D = A*D:\n" << D << std::endl;
    const torch::Tensor x = at::std(A);
    std::cout <<"Tensor x:\n" << x << std::endl;
    const torch::Tensor y = torch::std(B);
    std::cout <<"Tensor y:\n" << y << std::endl;
    int row = A.size(0);
    int cols = A.size(1);

    for (int i = 0; i <row; i++) {
        for (int j = 0; j <cols; j++) {
            float val = A.index({i,j}).item<float>();
            std::cout << "A[" << i << "][" << j <<"]="<<val<<std::endl;
        }
    }
    return 0;
}
