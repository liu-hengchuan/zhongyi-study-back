package com.example.myspringboot.controller;

import com.example.myspringboot.entity.ClassicBook;
import com.example.myspringboot.service.ClassicBookService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ClassicBookController.class)
public class ClassicBookControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ClassicBookService classicBookService;

    private ClassicBook classicBook;

    @BeforeEach
    void setUp() {
        classicBook = new ClassicBook();
        classicBook.setId(1);
        classicBook.setName("伤寒论");
        classicBook.setAuthor("张仲景");
        classicBook.setDynasty("东汉");
        classicBook.setCategory("经典著作");
        classicBook.setIntro("张仲景所著的伤寒杂病论，是中医经典著作");
    }

    @Test
    void getAllClassicBooks() throws Exception {
        List<ClassicBook> books = Arrays.asList(classicBook);
        when(classicBookService.list()).thenReturn(books);

        mockMvc.perform(get("/api/classic-books"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(books.size()))
                .andExpect(jsonPath("$[0].name").value(classicBook.getName()));

        verify(classicBookService, times(1)).list();
    }

    @Test
    void getClassicBookById() throws Exception {
        when(classicBookService.getById(1)).thenReturn(classicBook);

        mockMvc.perform(get("/api/classic-books/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(classicBook.getId()))
                .andExpect(jsonPath("$.name").value(classicBook.getName()));

        verify(classicBookService, times(1)).getById(1);
    }

    @Test
    void getClassicBooksByCategory() throws Exception {
        List<ClassicBook> books = Arrays.asList(classicBook);
        when(classicBookService.list(any())).thenReturn(books);

        mockMvc.perform(get("/api/classic-books/category/经典著作"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(books.size()))
                .andExpect(jsonPath("$[0].name").value(classicBook.getName()));

        verify(classicBookService, times(1)).list(any());
    }

    @Test
    void addClassicBook() throws Exception {
        when(classicBookService.save(any(ClassicBook.class))).thenReturn(true);

        mockMvc.perform(post("/api/classic-books")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"name\":\"伤寒论\",\"author\":\"张仲景\",\"dynasty\":\"东汉\",\"category\":\"经典著作\",\"intro\":\"张仲景所著的伤寒杂病论，是中医经典著作\"}"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(classicBookService, times(1)).save(any(ClassicBook.class));
    }

    @Test
    void updateClassicBook() throws Exception {
        when(classicBookService.updateById(any(ClassicBook.class))).thenReturn(true);

        mockMvc.perform(put("/api/classic-books")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"id\":1,\"name\":\"伤寒论\",\"author\":\"张仲景\",\"dynasty\":\"东汉\",\"category\":\"经典著作\",\"intro\":\"张仲景所著的伤寒杂病论，是中医经典著作\"}"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(classicBookService, times(1)).updateById(any(ClassicBook.class));
    }

    @Test
    void deleteClassicBook() throws Exception {
        when(classicBookService.removeById(1)).thenReturn(true);

        mockMvc.perform(delete("/api/classic-books/1"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(classicBookService, times(1)).removeById(1);
    }

    @Test
    void getClassicBooksPage() throws Exception {
        mockMvc.perform(get("/api/classic-books/page?page=1&size=10"))
                .andExpect(status().isOk());

        verify(classicBookService, times(1)).page(any());
    }
}