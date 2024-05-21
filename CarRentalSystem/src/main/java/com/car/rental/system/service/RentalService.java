package com.car.rental.system.service;

import com.car.rental.system.Model.Rental;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;


@Service
public interface RentalService {

    void createRental(Rental Rental);

    List<Rental> getAllRentals();

    List<Rental> getAllRentalsByUserId(int userId);

    Rental updateRentalByRentalId(Rental Rental, long RentalId);

    Optional<Rental> getRentalBYRentalID(int RentalId);

    void deleteRental(int RentalId);

}