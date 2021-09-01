import 'package:flutter/material.dart';
import 'package:future_jobs/models/category_model.dart';
import 'package:future_jobs/pages/second_homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class JobCard extends StatelessWidget {
  final CategoryModel category;

  JobCard(this.category);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondHomePage(category),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 150,
        margin: EdgeInsets.only(right: 24),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              bottom: 16,
              right: 16,
            ),
            child: Text(
              category.name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(category.imageUrl),
          ),
        ),
      ),
    );
  }
}
