package com.car.rental.system.controller;

import com.car.rental.system.Model.Car;
import com.car.rental.system.service.CarService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.validation.Valid;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
public class CarController {

    @Autowired
    private CarService carService;

    @GetMapping("/car")
    public String getAddCarPage(Model model) {
        Car car = new Car();
        model.addAttribute("car", car);
        return "addcar";
    }

    @GetMapping("/cars")
    public String getCarsPage(Model model) {
        List<Car> cars = carService.getAllCars();
        System.out.println(cars);
        model.addAttribute("cars", cars);
        return "cars";
    }

    @PostMapping("/car")
    public String createCar(@ModelAttribute("car") @Valid Car car, BindingResult bindingResult, @RequestParam("image") MultipartFile image, RedirectAttributes redirectAttributes) {
        try {
            if (bindingResult.hasErrors()) {
                redirectAttributes.addFlashAttribute("message", "Please provide required data!!");
            }
            System.out.println("Received image: " + image.getOriginalFilename() + ", size: " + image.getSize());

            try {
                carService.createCar(car, image);
                redirectAttributes.addFlashAttribute("message", "Successfully added Car!!");
                return "redirect:/dashboard/cars";
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("message", "Something went wrong!!");
                return "redirect:/dashboard/cars";
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "redirect:/dashboard/cars";
    }

    private static final Logger LOGGER = Logger.getLogger(CarController.class.getName());

    @Autowired
    private ResourceLoader resourceLoader;

    @GetMapping("/image/{imageName}")
    public void getImage(@PathVariable String imageName, HttpServletResponse response) {
        Resource resource = resourceLoader.getResource("file:src/main/resources/Images/" + imageName);

        try (InputStream inputStream = resource.getInputStream()) {
            if (!resource.exists()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                LOGGER.log(Level.WARNING, "Image not found: " + imageName);
                return;
            }

            String contentType = URLConnection.guessContentTypeFromName(imageName);
            if (contentType == null) {
                contentType = "application/octet-stream";
            }

            response.setContentType(contentType);
            try (OutputStream outputStream = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            LOGGER.log(Level.SEVERE, "Error serving image: " + imageName, e);
        }
    }

    @PostMapping("/cars/update")
    public String updateCar(@ModelAttribute("car") @Valid Car car, BindingResult bindingResult, @RequestParam("image") MultipartFile image,RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("message", "Please provide required data!!");
        }
        try {
            carService.updateCar(image, car, car.getId());
            redirectAttributes.addFlashAttribute("message", "Successfully updated Car!!");
            return "redirect:/dashboard/cars";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Something went wrong!!");
            return "redirect:/dashboard/cars";
        }
    }

    @GetMapping("/cars/update")
    public String updateCar(@RequestParam int carId, Model model) {
        Optional<Car> Car = carService.getCarBYCarID(carId);
        if (Car.isPresent()) {
            model.addAttribute("car", Car);
        } else {
            Car Car1 = new Car();
            model.addAttribute("car", Car1);
        }
        return "updateCar";
    }

    @GetMapping("/cars/delete/{carId}")
    public String deleteCar(@PathVariable("carId") int CarId) {
        carService.deleteCar(CarId);
        return "redirect:/dashboard/cars";
    }

    @GetMapping("/cars/car/{carId}")
    public String getSingleCarPage(@PathVariable("carId") int CarId, Model model) {
        Optional<Car> Car = carService.getCarBYCarID(CarId);
        System.out.println(Car.get().getModel());
        model.addAttribute("car", Car);
        return "singlecar";
    }


}