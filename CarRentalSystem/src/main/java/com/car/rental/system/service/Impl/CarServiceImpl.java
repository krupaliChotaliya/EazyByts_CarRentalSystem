package com.car.rental.system.service.Impl;

import com.car.rental.system.Model.Car;
import com.car.rental.system.Repository.CarRepository;
import com.car.rental.system.service.CarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;


@Service
public class CarServiceImpl implements CarService {

    @Autowired
    private CarRepository carRepository;

    @Override
    public void createCar(Car Car, MultipartFile image) throws Exception {
        try {
            String imageName = storeImage(image);
            Car.setImage(imageName);
            carRepository.save(Car);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("error" + e.getMessage());
        }
    }

    private String storeImage(MultipartFile image) throws Exception {
        String folderPath = "./src/main/resources/Images/";
        byte[] bytes = image.getBytes();
        Path path = Paths.get(folderPath + image.getOriginalFilename());
        Files.write(path, bytes);
        return image.getOriginalFilename();
    }


    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    @Override
    public List<Car> getAllCarsByUserId(int userId) {
        return carRepository.getAllCarsByUserId(userId);
    }

    @Override
    public Car updateCar(MultipartFile image, Car updatedCar, long CarId) {
        Car Car = carRepository.findById((int) CarId).orElse(null);
        try {
            String imageName = storeImage(image);
            System.out.println(updatedCar.getColor());
            assert Car != null;
            Car.setImage(imageName);
            Car.setModel(updatedCar.getModel());
            Car.setBrand(updatedCar.getBrand());
            Car.setColor(updatedCar.getColor());
            Car.setCapacity(updatedCar.getCapacity());
            Car.setLocation(updatedCar.getLocation());
            Car.setYear(updatedCar.getYear());
            Car.setType(updatedCar.getType());
            Car.setPrice_per_day(updatedCar.getPrice_per_day());
            carRepository.save(Car);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("error" + e.getMessage());
        }
        return Car;
    }

    @Override
    public Optional<Car> getCarBYCarID(int CarId) {
        return carRepository.findById(CarId);
    }

    @Override
    public void deleteCar(int CarId) {
        carRepository.deleteById(CarId);
    }

}