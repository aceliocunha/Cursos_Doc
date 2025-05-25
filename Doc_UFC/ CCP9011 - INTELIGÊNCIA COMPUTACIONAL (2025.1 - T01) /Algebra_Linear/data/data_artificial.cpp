#include <torch/torch.h>
#include  <iostream>
#include  <vector>
#include  <random>
#include <fstream>


struct ArtificialDataset :torch::data::Dataset<ArtificialDataset> {
    torch::Tensor features, labels;

    explicit ArtificialDataset(size_t n_samples = 1000) {
        std::vector<float> x1, x2;
        std::vector<float> y;
        std::mt19937 gen(42);
        std::normal_distribution<float> dist1(0.0, 1.0);
        std::normal_distribution<float> dist2(3.0, 1.0);
        for (size_t i = 0; i < n_samples/2; ++i) {
            x1.push_back(dist1(gen));
            x2.push_back(dist2(gen));
            y.push_back(0);

            x1.push_back(dist1(gen));
            x2.push_back(dist2(gen));
            y.push_back(0);


        }
        features = torch::stack({
            torch::from_blob(x1.data(), {(int)n_samples, 1}).clone(),
            torch::from_blob(x1.data(), {(int)n_samples, 1}).clone()}, 1).squeeze(2).to(torch::kFloat32);
        labels = torch::from_blob(y.data(), {(int)n_samples}, torch::kLong).clone();
    }

    torch::data::Example<> get(size_t index) override {
        return {features[index], labels[index]};
    }
    torch::optional<size_t> size() const override {
        return features.size(0);
    }
};


int main() {
    std::ofstream log("saida.txt");
    std::streambuf* original_cout = std::cout.rdbuf();
    std::cout.rdbuf(log.rdbuf());
    ArtificialDataset dataset(10);
    std::cout << "Tamalho do dataset" << dataset.size().value()<<std::endl;
    std::cout<<"Features shape"<<dataset.features.sizes()<<std::endl;
    std::cout<<"Primeiro Ponto:"<<dataset.features[0]<<std::endl;
    std::cout<<"Label Shape:"<<dataset.labels[0]<<std::endl;
    std::cout<<"Mean:"<<dataset.features.mean(0)<<std::endl;
    std::cout<<"Std:"<<dataset.features.std(0)<<std::endl;
    auto exemplo = dataset.get(0);
    std::cout<<"\nExemplos 0: \n";
    std::cout<<"- X = " << exemplo.data << "\n";
    std::cout.rdbuf(original_cout);
    std::cout <<"Aquivo salvo: saida.txt\n";
    return 0;
}
