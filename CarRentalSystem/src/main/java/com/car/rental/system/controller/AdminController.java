package com.car.rental.system.controller;

import com.car.rental.system.Model.Car;
import com.car.rental.system.Model.Rental;
import com.car.rental.system.Model.User;
import com.car.rental.system.service.CarService;
import com.car.rental.system.service.RentalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private UserController userController;

    @Autowired
    private RentalService rentalService;

    @Autowired
    private CarService carService;


    @GetMapping("/dashboard/users")
    public String getUsers(Model model) {
        List<User> users = userController.getUsers();
        model.addAttribute("users", users);
        return "DashBoard/users";
    }

    @GetMapping("/dashboard/cars")
    public String getCars(Model model) {
        List<Car> cars = carService.getAllCars();
        model.addAttribute("cars", cars);
        return "DashBoard/cars";
    }

    @GetMapping("/dashboard/rentals")
    public String getCategory(Model model) {
        List<Rental> rentals = rentalService.getAllRentals();
        model.addAttribute("rentals", rentals);
        return "DashBoard/rentalcars";
    }

}