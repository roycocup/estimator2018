<?php

namespace App\Controller;

use App\Entity\Answer;
use App\Entity\Project;
use App\Entity\Question;
use App\Form\ProjectType;
use App\Repository\ProjectRepository;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/project")
 */
class ProjectController extends Controller
{
    /**
     * @Route("/", name="project_index", methods="GET")
     */
    public function index(ProjectRepository $projectRepository): Response
    {
        return $this->render('project/index.html.twig', ['projects' => $projectRepository->findAll()]);
    }

    /**
     * @Route("/new", name="project_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $em = $this->getDoctrine()->getManager();
        $project = new Project();
        $questionRepo = $this->getDoctrine()->getRepository(Question::class);
//        $form = $this->createForm(ProjectType::class, $project);
//        $form->handleRequest($request);

        // if not all questions are answered
        if ($request->request->count() < count($questionRepo->findAll()) ){
            return false;
        }
//        if ($form->isSubmitted() && $form->isValid()) {
//            $em = $this->getDoctrine()->getManager();
//            $em->persist($project);
//            $em->flush();
//
//            return $this->redirectToRoute('project_index');
//        }
        if ($request->request->count() == count($questionRepo->findAll())){
            foreach ($request->request->all() as $formAnswer){
                $answer = new Answer();
                $answer->setAnswer($formAnswer);
                $answer->setQuestion($questionRepo->find(1));
                $answer->setProject($project);
                $project->addAnswer($answer);
                $em->persist($answer);
                $em->persist($project);
                $em->flush();
            }

        }

        return $this->render('project/new2.html.twig', [
            'project' => $project,
            'questions' => $questionRepo->findAll(),
//            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="project_show", methods="GET")
     */
    public function show(Project $project): Response
    {
        return $this->render('project/show.html.twig', ['project' => $project]);
    }

    /**
     * @Route("/{id}/edit", name="project_edit", methods="GET|POST")
     */
    public function edit(Request $request, Project $project): Response
    {
        $form = $this->createForm(ProjectType::class, $project);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('project_index', ['id' => $project->getId()]);
        }

        return $this->render('project/edit.html.twig', [
            'project' => $project,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="project_delete", methods="DELETE")
     */
    public function delete(Request $request, Project $project): Response
    {
        if ($this->isCsrfTokenValid('delete'.$project->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($project);
            $em->flush();
        }

        return $this->redirectToRoute('project_index');
    }
}
