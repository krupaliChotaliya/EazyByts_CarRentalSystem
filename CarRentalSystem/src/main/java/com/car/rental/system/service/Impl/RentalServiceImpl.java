package com.car.rental.system.service.Impl;

import com.car.rental.system.Model.Car;
import com.car.rental.system.Model.Rental;
import com.car.rental.system.Model.User;
import com.car.rental.system.Repository.CarRepository;
import com.car.rental.system.Repository.RentalRepository;
import com.car.rental.system.Repository.UserRepository;
import com.car.rental.system.service.RentalService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;


@Service
public class RentalServiceImpl implements RentalService {

    @Autowired
    private RentalRepository rentalRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CarRepository carRepository;

    @Override
    @Transactional
    public void createRental(Rental rental) {
        System.out.println(rental.getCar().getId());
        System.out.println(rental.getUser().getUserId());

        User existingUser = userRepository.findById(rental.getUser().getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Car existingCar = carRepository.findById(rental.getCar().getId())
                .orElseThrow(() -> new RuntimeException("Car not found"));

        rental.setUser(existingUser);
        rental.setCar(existingCar);

        rentalRepository.save(rental);
    }

    public List<Rental> getAllRentals() {
        return rentalRepository.findAll();
    }

    @Override
    public List<Rental> getAllRentalsByUserId(int userId) {
        return rentalRepository.getAllRentalsByUserId(userId);
    }

    @Override
    public Rental updateRentalByRentalId( Rental updatedRental, long RentalId) {
        Rental rental = rentalRepository.findById((int) RentalId).orElse(null);
        try {
            assert rental != null;
            rental.setStart_date(updatedRental.getStart_date());
            rental.setEnd_date(updatedRental.getEnd_date());
            rental.setPayment(updatedRental.getPayment());
            rental.setPayment_status(updatedRental.getPayment_status());
            rental.setUser(updatedRental.getUser());
            rentalRepository.save(rental);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("error" + e.getMessage());
        }
        return rental;
    }

    @Override
    public Optional<Rental> getRentalBYRentalID(int RentalId) {
        return rentalRepository.findById(RentalId);
    }

    @Override
    public void deleteRental(int RentalId) {
        rentalRepository.deleteById(RentalId);
    }
}