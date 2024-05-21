package com.car.rental.system.service;


import com.car.rental.system.Model.Car;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
import java.util.Optional;


@Service
public interface CarService {

    void createCar(Car car, MultipartFile image) throws Exception;

    List<Car> getAllCars();

    List<Car> getAllCarsByUserId(int userId);

    Car updateCar(MultipartFile image, Car car, long CarId);

    Optional<Car> getCarBYCarID(int CarId);

    void deleteCar(int CarId);

}