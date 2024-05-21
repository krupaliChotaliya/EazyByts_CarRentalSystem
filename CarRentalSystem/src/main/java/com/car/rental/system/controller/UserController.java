package com.car.rental.system.controller;

import com.car.rental.system.Model.Car;
import com.car.rental.system.Model.User;
import com.car.rental.system.service.CarService;
import com.car.rental.system.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.List;
import java.util.Optional;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private CarService carService;


    @GetMapping("/")
    public String getHome(Model model) {
        List<Car> cars = carService.getAllCars();
        List<Car> firstThreeCars = cars.subList(0, Math.min(cars.size(), 3));
        model.addAttribute("cars", firstThreeCars);
        return "index";
    }

    @GetMapping("/user")
    public String getAddUserPage(Model model) {
        User user = new User();
        model.addAttribute("user", user);
        return "addUser";
    }

    @PostMapping("/user")
    public String CreateUser(@Valid User user, BindingResult bindingResult, Model model) {
        userService.saveUser(user);
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "please provide required data!!");
            return "addUser";
        }
        try {
            model.addAttribute("message", "Successfully added User!!");
            return "redirect:/dashboard/users";
        } catch (Exception e) {
            model.addAttribute("message", "Something went wrong!!");
            return "addUser";
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm() {
        return "register";
    }

    @PostMapping("/login")
    public String getLogin(@ModelAttribute User user, Model model, HttpServletRequest request) {
        if (user.getEmail() != null && !user.getEmail().isEmpty() && user.getPassword() != null && !user.getPassword().isEmpty()) {
            User user1 = userService.getlogin(user.getEmail(), user.getPassword());
            if (user1 != null) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", user1.getEmail());
                session.setAttribute("role", user1.getRole());
                return "redirect:/";
            } else {
                model.addAttribute("error", "Invalid username or password");
                return "login";
            }
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }
    }

    @PostMapping("/register")
    public String getRegister(@ModelAttribute User user, Model model) {
        if (user.getEmail() != null && user.getUsername() != null && !user.getEmail().isEmpty() && user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setRole("normal");
            User user1 = userService.saveUser(user);
            if (user1 != null) {
                return "redirect:/login";
            } else {
                model.addAttribute("error", "something went wrong!!");
                return "register";
            }
        } else {
            model.addAttribute("error", "Please enter valid details");
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("userId");
        }
        return "redirect:/login";
    }

    public User getUserByEmail(String email) {
        return userService.getUser(email);
    }

    public List<User> getUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/users/update")
    public String updateUser(@RequestParam int userId, Model model) {
        Optional<User> user = userService.getUserBYUserId(userId);
        if (user.isPresent()) {
            model.addAttribute("user", user);
        } else {
            User user1 = new User();
            model.addAttribute("user", user1);
        }
        return "updateUser";
    }

    @PostMapping("/users/update")
    public String updateUser(@Valid User user, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "please provide required data!!");
            return "redirect:/dashboard/users";
        }
        try {
            userService.updateUser(user, user.getUserId());
            model.addAttribute("message", "Successfully Updated user!!");
            return "redirect:/dashboard/users";
        } catch (Exception e) {
            model.addAttribute("message", "Something went wrong!!");
            return "redirect:/dashboard/users";
        }
    }

}
