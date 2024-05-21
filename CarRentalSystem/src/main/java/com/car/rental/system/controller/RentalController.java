package com.car.rental.system.controller;

import com.car.rental.system.Model.Rental;
import com.car.rental.system.service.RentalService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class RentalController {

    @Autowired
    private RentalService rentalService;


    @GetMapping("/rental")
    public String getAddrentalPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("error", "You are not logged in!!");
            return "login";
        }
        Rental rental = new Rental();
        model.addAttribute("rental", rental);
        return "addrental";
    }

    @PostMapping("/rental/book")
    @ResponseBody
    public ResponseEntity<Map<String, String>> createRental(@Valid @RequestBody Rental rental, BindingResult bindingResult) {
        Map<String, String> response = new HashMap<>();
        try {
            if (bindingResult.hasErrors()) {
                response.put("error", "Please provide required data!!");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            }
            rentalService.createRental(rental);
            response.put("message", "Booking successful!");
            System.out.println(response +"***********************");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("message", "Booking failed. Please try again.");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/rentals/update")
    public String updateRental(@Valid Rental rental, BindingResult bindingResult, @RequestParam("imagePath") MultipartFile image, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "please provide required data!!");
            return "redirect:/rentals/rental";
        }
        try {
            rentalService.updateRentalByRentalId(rental, rental.getId());
            model.addAttribute("message", "Successfully Updated rental!!");
            return "redirect:/rentals/rental";
        } catch (Exception e) {
            model.addAttribute("message", "Something went wrong!!");
            return "redirect:/rentals/rental";
        }
    }

    @GetMapping("/rentals/update")
    public String updateRental(@RequestParam int rentalId, Model model) {
        Optional<Rental> rental = rentalService.getRentalBYRentalID(rentalId);
        if (rental.isPresent()) {
            model.addAttribute("rental", rental);
        } else {
            Rental rental1 = new Rental();
            model.addAttribute("rental", rental1);
        }
        return "Updaterental";
    }

    @GetMapping("/rentals/delete/{rentalId}")
    public String deleterental(@PathVariable("rentalId") int rentalId) {
        rentalService.deleteRental(rentalId);
        return "redirect:/rentals/rental";
    }

    @GetMapping("/rentals/rental/{rentalId}")
    public String getrental(@PathVariable("rentalId") int rentalId, Model model) {
        Optional<Rental> rental = rentalService.getRentalBYRentalID(rentalId);
        model.addAttribute("rental", rental);
        return "rental";
    }

    @GetMapping("/rentals")
    public List<Rental> getAllrentals() {
        return rentalService.getAllRentals();
    }
}